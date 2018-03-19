-- You should NOT modify contents of this file!!

import ETF_Test_Parameters

import Control.Applicative

import Control.Monad (forM, forM_)

import Data.List (isInfixOf)
import Data.Text (split, pack, unpack, replace, strip)

import System.Directory (canonicalizePath, doesFileExist, doesDirectoryExist, getCurrentDirectory, setCurrentDirectory)
import System.Exit
import System.FilePath ((</>))
import System.IO (writeFile)
import System.Info
import System.Process (rawSystem, readProcess, readProcessWithExitCode)
import System.Timeout

import Text.Printf (printf)

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Main Function
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main :: IO ()
main = do
        -- force a crash on windows, otherwise proceed
    platform `seq` return ()
    messages <- exec [ checkAllFilesExist   acceptance_tests
                     , checkDirectoryExists log_dir
                     , getExpectedFiles     acceptance_tests
                     , if is_expected
                        then skip
                        else checkFileExists oracle
                     , checkFileExists      (executable platform)
                                         ]

    if all thereIsNoError messages 
        then do
            results <- runAcceptanceTests acceptance_tests
            printTestResults results
            printMessages    results
            printTestResults results
        else do
            printMessages    messages

platform :: OperatingSystem
platform = case os of
    "darwin" -> MacOSX
    "linux"  -> Linux
    _        -> error "unsupported platform"

printMessages :: [Message] -> IO ()
printMessages messages = do
    forM_ messages (\m -> do
        let msg = show m 
        if null msg 
            then return () 
            else putStrLn msg 
        )
        
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Definitions and operatios on data types
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data Message = 
      Success   String
    | Error     String

type Operation = IO [Message]

msgBody :: Message -> String
msgBody (Success msg) = msg
msgBody (Error   msg) = msg

instance Show Message where
    show msg = case msg of
        Success out -> if null out then out else printf "Success: %s" out
        Error   err -> printf "Error: %s" err

-- Is there an error returned from the check?
thereIsAnError :: Message -> Bool
thereIsAnError (Error _) = True
thereIsAnError _         = False

-- Is there no error returned from the check?
thereIsNoError :: Message -> Bool
thereIsNoError =  not . thereIsAnError

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Operations
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- Execute a sequence of messages-returning operations. 
-- Stop as soon as an error is detected. 
exec :: [Operation] -> Operation
exec (op:[])  = op
exec (op:ops) = do
    checks <- op 
    if all thereIsNoError checks 
        then exec ops
        else return checks
        
skip :: IO [Message]
skip = return []
        
-- Given the paths to a list of test case files, call 'getExpectedFile' to 
-- either copy or generate the expected files.
getExpectedFiles :: [FilePath] -> IO [Message]
getExpectedFiles at_files =
    concat <$> mapM getExpectedFile at_files
        
-- Given the path to an acceptance test case file, depending the value of 'is_expected',
-- either copy its corresponding expected file to the 'log_dir' directory, or
-- generate its corresponding expected file using the 'oracle'.
getExpectedFile :: FilePath -> IO [Message]
getExpectedFile at_file_path = do
    let at_file_path_split     = splitPath at_file_path
        at_file_dir            = fst at_file_path_split
        at_file_name           = snd at_file_path_split
        expected_file_name     = applyReplace ".txt" ".expected.txt" at_file_name
        log_expected_file_path = log_dir </> expected_file_name
    if is_expected 
        -- Case 1: Copy the corresponding expected file, in where 'at_file_path' resides, into 'log_dir'.
        then do
            let existing_expected_file_path = at_file_dir </> expected_file_name
            expectedFileExists <- doesFileExist existing_expected_file_path
            if expectedFileExists 
                then do
                    _ <- cpFile existing_expected_file_path log_expected_file_path
                    return $ [Success []]
                else do
                    return $ [Error (printf "File %s cannot be found." existing_expected_file_path)]
        -- Case 2: Run 'oracle' on 'at_file_path' and wrote the output into 'log_dir'.
        else do
            abs_at_file_path <- getAbsolutePath at_file_path
            expected         <- runExecutable oracle ["-b", abs_at_file_path]
            if thereIsNoError expected then do
                let expected_output = msgBody expected
                writeFile log_expected_file_path expected_output
                putStrLn $ printf "Output produced by %s wrote to %s." oracle log_expected_file_path
                return $ [Success []]
            else
                -- error message
                return [expected]

-- Given a list of acceptance test files, run them one-by-one using 'runAcceptanceTest'.    
runAcceptanceTests :: [FilePath] -> IO [Message]
runAcceptanceTests at_files = do
    concat <$> mapM runAcceptanceTest at_files
    
printTestResults :: [Message] -> IO ()
printTestResults messages = do
    let numTests   = length messages
        numSuccess = length $ filter thereIsNoError messages
        result     = printf "Test Results: %i/%i passed." numSuccess numTests
        sep        = cus_sep '=' [result]
    putStrLn $ printf "%s\n%s\n%s" sep result sep
            
-- Given an acceptance test file: 
-- 1) generate the expected output file using 'oracle';
-- 2) generate the actual output file using 'executable'; and
-- 3) determine if the two outputs are consistent.
-- runAcceptanceTest :: FilePath -> IO [Message]
-- Assumptions:
-- The corresponding expected file for the given acceptance test file already exists.
runAcceptanceTest :: FilePath -> IO [Message]
runAcceptanceTest at_file_path = do
    let header = printf "Running acceptance test from file %s." at_file_path
    putStrLn $ cus_sep '=' [header]
    putStrLn header
    
    let at_file_name       = snd . splitPath $ at_file_path
        expected_file_name = applyReplace ".txt" ".expected.txt" at_file_name
        actual_file_name   = applyReplace ".txt" ".actual.txt"   at_file_name
        expected_file_path = log_dir </> expected_file_name
        actual_file_path   = log_dir </> actual_file_name
    
    abs_at_file_path <- getAbsolutePath at_file_path
    putStrLn abs_at_file_path   
    actual           <- runExecutable (executable platform) ["-b", abs_at_file_path]
    if thereIsNoError actual then do
        expected_output <- readProcess "cat" [expected_file_path] []

        let actual_output = msgBody actual
        writeFile actual_file_path   actual_output
        putStrLn $ printf "Output produced by %s wrote to %s." 
            (executable platform) actual_file_path

        let matched = if is_tolerant_on_white_spaces
                        then same actual_output expected_output
                        else actual_output == expected_output
        if matched 
            then return $ [Success (printf "%s and %s are identical." expected_file_path actual_file_path)]
            else return $ [Error   (printf "%s and %s do not match."  expected_file_path actual_file_path)]
    else
        return [actual] 

-- Given an existing executable and its arguments, run the execution.
runExecutable :: FilePath -> [String] -> IO Message 
runExecutable exe_path args = do
    let execution      = show $ [exe_path] ++ args
        exe_path_split = splitPath exe_path
        exe_dir        = fst exe_path_split
        exe_name       = snd exe_path_split
        --bound          = "180s"
        bound          = 180 * 1000000 -- 180s in microseconds
    
    old_current <- getCurrentDirectory
    setCurrentDirectory $ exe_dir -- temporarily go to where the exe_file is stored
    --(ec, out, err) <- readProcessWithExitCode "timeout" ([bound, "." </> exe_name] ++ args) []

    x <- timeout bound $ 
        readProcessWithExitCode ("." </> exe_name) args []
    case x of
        Just (ec, out, err) -> do
            setCurrentDirectory $ old_current
            if ec == ExitFailure 124 
                then return $ Error $ printf "Error: execution of %s timed out after %s" execution bound
            else -- case where the timeout returns the exit status of the executed program
                if ec == ExitSuccess then do
                    if null err 
                        then return $ Success out
                        else return $ Error   err
                else do
                    let msg = "Execution of " ++ execution ++ " failed to terminate normally." 
                    return $ if isInfixOf "Following is the set of recorded exceptions:" err 
                                then Error (printf "%s\n%s\n" msg (printExceptionTrace err))
                                else Error (printf "%s\n%s\n" msg err)
        Nothing -> -- timeout
            return $ Error $ printf "Error: execution of %s timed out after %s" execution bound

-- Check if all given paths refer to existing files.        
checkAllFilesExist :: [FilePath] -> IO [Message]
checkAllFilesExist files =
    concat <$> mapM checkFileExists files
    -- Equivalent to these two lines:
    -- checks <- mapM checkFileExists files
    -- return $ concat checks

-- Check if the given path refers to an existing file.  
checkFileExists :: FilePath -> IO [Message]
checkFileExists file = do
    fileExists <- doesFileExist file
    return $ if fileExists
        then [Success []]
        else [Error   (printf "File %s cannot be found." file)]

-- Check if the given path refers to an existing directory.
checkDirectoryExists :: FilePath -> IO [Message]
checkDirectoryExists dir = do
    dirExists <- doesDirectoryExist dir
    return $ if dirExists
        then [Success []]
        else [Error   (printf "Directory %s cannot be found." dir)]

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Auxiliary Pure Functions
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- Given a path, split into its context path and file/directory name.
splitPath :: FilePath -> (FilePath, String)
splitPath p = 
    let components = applySplit (== '/') p 
        context    = init components
        name       = last components
    in  (foldr (</>) [] context, name)

applyReplace :: String -> String -> String -> String
applyReplace old new src = 
    unpack $ replace (pack old) (pack new) (pack src)

applySplit :: (Char -> Bool) -> String -> [String]
applySplit d src =
    map unpack (split d $ pack src)

printExceptionTrace :: String -> String
printExceptionTrace msg = 
    let tokens  = filter (not . null) . applySplit (== '-') $ msg
        header  = tokens !! 1
        fst_ex  = tokens !! 2
        sep     = cus_sep '-' [header]
    in  printf "%s%s%s%s%s" sep header sep fst_ex sep


printErrMsgs :: [Message] -> String
printErrMsgs msgs = 
    let errMsgs          = filter thereIsAnError msgs
        numErrs          = length errMsgs
        annotatedErrMsgs = zip [1 .. numErrs] errMsgs
    in  foldr ((++) . (\(id, errMsg) -> 
                            show errMsg ++ if id < numErrs then "\n" else [])) 
        [] annotatedErrMsgs

-- A tolerate version of 'diff'
-- ignored:
-- 1. leading and trailing spaces
-- 2. leading and trailing lines containing white spaces
same :: String -> String -> Bool
same s1 s2 =
    trim s1 == trim s2
    where
        trim = filter (/= []) . map words . lines

-- Seperator customized to the maximum length of the given strings.
cus_sep :: Char -> [String] -> String
cus_sep c ss = 
    map (\_ -> c) [1..(maximum . map length $ ss)]

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Auxiliary IO Functions
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
-- Given a relative path of a file, return its absolute path.   
getAbsolutePath :: FilePath -> IO FilePath
getAbsolutePath relative_path = do
    -- out <- readProcess "readlink" ["-f", relative_path] []
    -- return $ init out -- get rid of the ending newline character 
    out <- canonicalizePath relative_path
    return out

-- Copy files
cpFile :: FilePath -> FilePath -> IO ExitCode
cpFile src tar = do
    putStrLn $ printf "File %s is copied to %s." src tar
    rawSystem "cp" ["-p", src, tar]