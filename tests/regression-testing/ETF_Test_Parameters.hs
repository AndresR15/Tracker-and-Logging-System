module ETF_Test_Parameters where

data OperatingSystem = Linux | MacOSX

-- Should the regression testing proceeds with a list 
-- of expected files, or the oracle?
-- When this flag is set True, the the value of 'oracle' is ignored. 
is_expected = True

-- Specify where you put the oracle.
oracle = ""

-- Set true if you want the comparison to be tolerant on white spaces and empty lines.
is_tolerant_on_white_spaces = True

-- Specify the path of the executable built from your project.  
executable :: OperatingSystem -> FilePath
executable MacOSX = "./tracker.osx.exe"
-- executable MacOSX = "./osx"
executable Linux  = "../oracle.exe"

-- Specify where you want to log the outputs 
-- from both the oracle and your executable.
-- In the case 'is_expected' is set to True, 
--   expected output files are copied from the directory 
-- containing 'acceptance_tests' into 'log_dir'
-- In the case 'is_expected' is set to False,
--   expected output files are generated using 'oracle' into 'log_dir'
log_dir = "./log"

-- Specify the list of (relative or absolute) paths of the acceptance test files.
acceptance_tests = 
    [ "../at1.txt"
	 ,"../at2.txt"
   ]
