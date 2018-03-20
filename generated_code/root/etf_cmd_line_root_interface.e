note
	description : "root class"
	date        : "$Date$"
	author      : "Jackie Wang"
	revision    : "$Revision$"
deferred class
	ETF_CMD_LINE_ROOT_INTERFACE

inherit
	ARGUMENTS

	ETF_GUI_ROOT_INTERFACE
		rename
			make as make_from_gui_root
		end

feature {NONE} -- init

	make
		-- initialise and execute commands
	  local
		flag, msg, cmd: STRING
		input_path: STRING
	  	output_path: STRING
	  	input_file: ETF_FILE_UTILITY
	  	output_file: PLAIN_TEXT_FILE
	  do
		cmd  := argument_array[0]
		create msg.make_empty
		initialize_attributes

		if argument_count >= 1 then
		  flag := argument_array[1]

		  -- %%%%%%%%%%%%%% Help Mode %%%%%%%%%%%%%%%%%%
		  if flag ~ "-help" then
			if argument_count = 1 then
			  msg := usage_msg (cmd)
			else
			  msg := error (wrong_arguments_for_mode(flag), cmd)
			end
		  elseif flag ~ "-version" then
			if argument_count = 1 then
			  msg := version_msg
			else
			  msg := error (wrong_arguments_for_mode(flag), cmd)
			end
		  -- %%%%%%%%%%%%%%%% GUI Mode %%%%%%%%%%%%%%%%%
		  elseif flag ~ "-g" then
		  	if argument_count = 1 then
			  make_from_gui_root
			else
			  msg := error (wrong_arguments_for_mode(flag), cmd)
			end
		  -- %%%%%%%%%%%% Interactive Mode %%%%%%%%%%%%%
		  elseif flag ~ "-i" then
		  	if argument_count = 1 then
		      is_init := true
		      handle_interactive_mode
		    else
		      msg := error (wrong_arguments_for_mode(flag), cmd)
		  	end
		  -- %%%%%%%%%%%%%%%% Batch Mode %%%%%%%%%%%%%%%%
		  elseif flag ~ "-b" then
		    if argument_count = 2 then
		      input_path := argument_array[2]
		  	  is_init := true
			  msg := handle_batch_mode (input_path)
			elseif argument_count = 3 then
			  input_path  := argument_array[2]
		  	  output_path := argument_array[3]
		  	  is_init := true
			  -- check that input file exists
			  create input_file.read_text_from (input_path)
		  	  if NOT input_file.error then
		  	  	-- check that output file does NOT exist
		  	  	create output_file.make_with_name (output_path)
		  	  	if NOT output_file.exists then
		  	  	  input_file.remove_comment_lines
				  handle_batch_file_mode (input_file, output_file)
				else
				  msg := "Error: output file " + output_path + " already exists!"
		  	  	end
		  	  else
		  	  	msg := input_file.error_string
		  	  end
		    else
		      msg := error (wrong_arguments_for_mode(flag), cmd)
		    end
		  -- %%%%%%%%%%%%%%%% Window Mode %%%%%%%%%%%%%%%%
		  elseif flag ~ "-w" OR flag ~ "-l" then
		  	-- window mode case 1: start and end are specified
		  	if
		  	  flag ~ "-w" and then (argument_count = 4 OR argument_count = 5)
		  	  OR
			  flag ~ "-l" and then (argument_count = 2 OR argument_count = 3)
		  	then
		  	  -- set input and output paths for both "-w" and "-l" modes
		  	  if flag ~ "-w" then
		  	  	validate_window_spec (cmd)
		  	  	input_path := argument_array[4]
		  	  	if argument_count = 5 then
				  output_path := argument_array[5]
				else
				  output_path := ""
		  	  	end
			  else -- "-l" ==> no need to check for window spec.
			    last_window_slice_specified := TRUE
			    input_path := argument_array[2]
			    if argument_count = 3 then
				  output_path := argument_array[3]
			    else
			      output_path := ""
			    end
		  	  end

		  	  if window_spec_error.is_empty then
				-- check: input file exists
  	            create input_file.read_text_from(input_path)
  	            if NOT input_file.error then
  	          	  if NOT output_path.is_empty then
				    -- check: output file does NOT exist
  	  	            create output_file.make_with_name (output_path)
  	  	            if NOT output_file.exists then
  	  	              output_file.open_append
  	  	          	  io.set_file_default (output_file)
		              is_init := true
		              input_file.remove_comment_lines
		              handle_window_mode (input_file)
		              io.set_output_default
		            else
		          	  msg := "Error: output file " + output_path + " already exists!"
  	  	            end
  	  	          else
				    -- no output file specified => no need to redirect std out
  	                is_init := true
  	                input_file.remove_comment_lines
		            handle_window_mode (input_file)
  	          	  end
  	            else
  	          	  msg := input_file.error_string
  	            end
			  else
			  	msg := window_spec_error
		  	  end
			else
			  msg := error (wrong_arguments_for_mode(flag), cmd)
		  	end
		  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		  else -- invalid mode is specified
		  	msg := error (invalid_flag_msg (flag), cmd)
		  end
		-- ===================================================
		else -- no arguments are specified
		  msg := error (flag_missing_msg, cmd)
		end

		-- ===================================================
		if NOT msg.is_empty then
			io.print (msg)
			if NOT (msg[msg.count] = '%N') then
			io.print ("%N")
			end
		end
	end

	initialize_attributes
		do
			create window_spec_error.make_empty
			create exec_log.make_empty
			create context_state_from_exec_log.make_empty
		end

feature {NONE} -- message queries

    wrong_defns_file_chosen_msg : STRING =
      	"Application quit: please choose the right file with event declaratons"

	ref_msg (cmd: STRING) : STRING
		do
			Result := "Run '" + cmd + " -help' to see more details"
		end

	error (err_msg: STRING; cmd: STRING): STRING
		do
			Result := err_msg + "%N"
			Result.append (ref_msg (cmd))
		end

	invalid_flag_msg_or_num_args (f: STRING): STRING
		do
			Result := "Error: either " + f + " is not a valid option, or " +
					f + " is not specified with the correct number of arguments"
		end

	version_msg: STRING
		do
			Result := "Eiffel Testing Framework (ETF) Version: " + etf_version
		end

	usage_msg (cmd: STRING) : STRING
		do
			Result :=
				"The executable " + cmd + " may be invoked as: %N" +
				"%T" + cmd + " -help %N" +
				"%T" + cmd + " -version %N" +
				"%T" + cmd + " -i %N" +
				"%T" + cmd + " -b     input.txt [output.txt] %N" +
				"%T" + cmd + " -w m n input.txt [output.txt] %N" +
				"%T" + cmd + " -l     input.txt [output.txt] %N" +
				"where %N" +
				" ====================================%N" +
				"  Option %N" +
				"    -g  gui mode: run the ETF project as a GUI %N" +
				"%N" +
				"    -i  interactive mode: read the event trace from console %N" +
				"%N" +
				"    -b  batch mode: read the event trace from file 'input.txt' %N" +
				"        Note. An output file is specified to log results of a large input file. %N" +
				"%N" +
				"    -w  window mode: same as batch mode, except that only results of the %N" +
				"        m^th to (n-1)^th input commands, when m > 0 and n > 0, are logged into the output file. %N" +
				"        Use negative numbers -1, -2, etc., to denote the last, 2nd last, etc, input commands. %N" +
				"        Constraints: 1. if m <= 0, then n <= 0 %N" +
				"                     2. if m >  0, then n >  0 %N" +
				"                     3. m <= n %N" +
				"        Note. A window with valid start 'm' and end 'n' has the log: %N" +
				"              S_m C_m S_m+1 C_m+1 ... S_n Cn S_n+1 %N" +
				"              where S_i and S_i+1, m <= i <= n, denote the starting and resulting states of command C_i %N" +
				"        Note. When m = n, only the starting state of the input command denoted by 'm' is logged. %N" +
				"        Examples. Use '1   1' as the window to log the initial state. %N" +
				"                  Use '1   2' as the window to log the 1st command and its starting and resulting states. %N" +
				"                  Use '2   2' as the window to log the starting state of the 2st command. %N" +
				"                  Use '-1 -1' as the window to log the resulting state of the 2nd last command. %N" +
				"                  Use '-1  0' as the window to log the last command and its starting and resulting states. %N" +
				"                  Use '0   0' as the window to log the final state. %N" +
				"                  Use 'm   _' (m > 0) as the window to log the m^th to the last commands. %N" +
				"                  Use 'm   _' (m < 0) as the window to log the m^th last to the last commands. %N" +
				"%N" +
				"    -l last mode: a special case of the -w mode with the window specified as '-1 0' or '-1 _'. %N" +
				" ===================================="
	end

	flag_missing_msg: STRING
		do
			Result := "Error: a mode is not specified"
		end

	invalid_flag_msg (flag: STRING): STRING
		do
			Result := "Error: '" + flag + "' is not a valid mode"
		end

	wrong_arguments_for_mode (flag: STRING): STRING
		do
			Result := "Error: wrong number of arguments for the '" + flag + "' mode"
		end

	wrong_num_args_msg: STRING
		do
			Result := "Error: wrong number of arguments"
		end

	start_of_window_not_valid: STRING
		do
			Result := "Error: the start of window is not a valid integer"
		end

	neg_start_pos_end_window_msg: STRING
		do
			Result := "Error: when the start of a window is non-positive, its end must be a non-positive number"
		end

	end_of_window_not_valid: STRING
		do
			Result := "Error: the end of window is neither a valid integer nor '_'"
		end

	invalid_window_msg: STRING
		do
			Result := "Error: a window [start, end) should be such that start <= end"
		end

feature {NONE} -- attributes

	window_spec_error: STRING

	-- used to make sure 'init' is displayed only once	
	is_init : BOOLEAN

	exec_log : STRING

    -- attributes for batch file mode
	chunk_size_for_file_mode : INTEGER = 100

    -- attributes for window mode
	start_of_window : INTEGER
	end_of_window   : INTEGER
	end_of_window_unbounded : BOOLEAN
	last_window_slice_specified: BOOLEAN
	context_state_from_exec_log: STRING

feature {NONE} -- mode handling procedures

	handle_interactive_mode
	  local
	    user_input: STRING
	    to_quit: BOOLEAN
	    sys: ETF_SOFTWARE_OPERATION
	    input: ETF_INPUT_HANDLER
	    output: ETF_CMD_LINE_OUTPUT_HANDLER
	    ui: ETF_ABSTRACT_UI
	  do
	  	create sys.make

	    from
	      exec_log := sys.output.model_state
	      io.print (exec_log)
	  	  to_quit := false
	    until
	  	  to_quit
	    loop
	      io.print ("->")
		  io.read_line
		  user_input := io.last_string

		  if user_input ~ "quit" then
		    to_quit := true
		  elseif user_input ~ "man" then
		  	io.print (man_page + "%N")
		  else
			create ui.make
	      	create input.make_without_running(user_input, ui)
	      	create output.make
			input.on_error.attach (agent output.log_error)

			input.parse_and_validate_input_string
	      	if input.etf_error then
				exec_log := output.error_message + "%N"
			else
				sys.execute_without_log (user_input)
				exec_log := sys.output.model_state
	      	end
	      	io.print (exec_log)
	  	  end
	  	end
	end

	handle_batch_mode (input_path: STRING): STRING
	  local
	    input_file: ETF_FILE_UTILITY
	  do
		  create Result.make_empty
		  -- ===========================================
		  -- check 1: 'input' file exists and is readable
		  create input_file.read_text_from (input_path)

		  if NOT input_file.error then
	      	-- tasks of syntax check and event type validation
	      	-- are delegated to 'sys : ETF_SOFTWARE_OPERATION'
	      	input_file.remove_comment_lines
		    exec (input_file.item)
		    Result := exec_log
		  else
		    Result := input_file.error_string
		  end
	  end

	handle_batch_file_mode(input_file: ETF_FILE_UTILITY; output_file: PLAIN_TEXT_FILE)
	  -- assumptions: 1. input_path denotes an existing file
	  --              2. output_path denotes an non-existing file
		local
			i, j: INTEGER
	    	input_file_chunk: STRING
		do
		  create input_file_chunk.make_empty
		  -- counters for the file mode
		  i := 0 -- number of input lines read for the current chunk
	      j := 0 -- number of input chunks (i.e., mutiples of 'chunk_size_for_file_mode')

	      across input_file.items as line
	      loop
	        i := i + 1
	        if i = chunk_size_for_file_mode then
			  -- if the chunk has accumulated 1000 lines, then
	      	  -- exec and write append to the output file
	      	  input_file_chunk.append (line.item + "%N")
	      	  batch_file_mode_make_a_step(
	      	    input_file_chunk, output_file)

	      	  -- reset the chunk and counter
	      	  input_file_chunk.make_empty
	      	  j := j + 1
	      	  i := 0
			else
			  input_file_chunk.append (line.item + "%N")
	      	end
	      end

	      -- case where the LAST chunk was not filled completely
	      if i <= chunk_size_for_file_mode then
			batch_file_mode_make_a_step(
				input_file_chunk, output_file)
	      end
		end

	handle_window_mode(input_file: ETF_FILE_UTILITY)
		-- assumption: input file exists
		local
			k: INTEGER
	    	input_file_chunk: STRING
	    	num_cmds: INTEGER
		do
		  num_cmds := input_file.items.count
		  -- re-calculate start_of_winodw and end_of_window if necessary

		  if last_window_slice_specified then
			start_of_window := num_cmds
			end_of_window := num_cmds + 1
		  else
			-- re-calculate start_of_window if necessary
			if start_of_window <= 0 then
              start_of_window := num_cmds + start_of_window + 1
            else
              -- start_of_window > 0, no need to re-calculate
			end

			-- re-calculate end_of_window if necessary
			if end_of_window_unbounded then
			  end_of_window := num_cmds + 1
			else
			  if end_of_window <= 0 then
				end_of_window := num_cmds + end_of_window + 1
			  else
				-- end_of_window > 0, no need to re-calculate
			  end
			end
		  end

		  create input_file_chunk.make_empty
	      -- counters for the window mode
	      k := 0
	      create context_state_from_exec_log.make_empty

	      across input_file.items as line
	      loop
	        k := k + 1
	        if k <= end_of_window then
	          input_file_chunk.append (line.item + "%N")
	      	  window_mode_make_a_step(k, input_file_chunk)
	        else
	          -- do nothing beyond the window
	        end

	      	-- reset the chunk
	      	input_file_chunk.make_empty
	      end

		  -- case where '0 0' is specified in the window mode
		  -- to log the final state
	      if start_of_window = num_cmds + 1 and then
	      	   end_of_window = num_cmds + 1
	      then
		    io.put_string (context_state_from_exec_log)
	      end
		end

feature {NONE} -- auxiliary procedures

	validate_window_spec (cmd: STRING)
		require
			argument_array[1] ~ "-w" and then
			  (argument_count = 4 OR argument_count = 5)
	    local
	    	msg: STRING
		do
		  create msg.make_empty
		  -- check 1: start of window is an integer
		  if argument_array[2].is_integer then
		  	start_of_window := argument_array[2].to_integer

			-- check 2: end of window is an integer or _ (unbounded)
			if argument_array[3].is_integer OR ELSE
		  	  argument_array[3] ~ "_"
		  	then
		  	  if argument_array[3].is_integer then
			    end_of_window := argument_array[3].to_integer
			  elseif argument_array[3] ~ "_" then
			    end_of_window_unbounded := TRUE
			  end

		      -- check 3: start of window <= end of window
			  if end_of_window_unbounded OR ELSE
		        start_of_window <= end_of_window
			  then
			    -- check 4: start of window <= 0 ==> end of window <= 0
			    if start_of_window <= 0 and end_of_window > 0 then
				  msg := error(neg_start_pos_end_window_msg, cmd)
				else
				  -- no error on the window spec!
				end
		  	  else
				msg := error(invalid_window_msg, cmd)
		  	  end
			else
			  msg := error (end_of_window_not_valid, cmd)
		  	end
		  else
		  	msg := error (start_of_window_not_valid, cmd)
		  end
		  window_spec_error := msg
		end

	batch_file_mode_make_a_step(
	  input_file_chunk: STRING; output_file: PLAIN_TEXT_FILE)
		do
			exec (input_file_chunk)
			output_file.open_append
		    output_file.put_string (exec_log)
		    output_file.close
		end

	window_mode_make_a_step(line: INTEGER; input_file_chunk: STRING)
		local
			sys: ETF_SOFTWARE_OPERATION
		do
			-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			-- Right before the start of window, log the command and
			-- retrieve its resulting state
			-- i.e., the context state for the 1st command in the window
			-- Note. Since 'line' starts with 1, when start of window is 1,
			-- then we bypass ths branch and rely on the output handler
			-- to log the initial state, the 1st command, and the resulting state.
			if line = start_of_window - 1 then
			  exec (input_file_chunk)
			  retrieve_context_state_from_exec_log
			-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			-- start_of_window = end_of_window denotes the
			-- context state of the 1st command in the window
			elseif start_of_window = line and
			                         line = end_of_window
			then
			  if start_of_window > 1 then
			  	io.put_string (context_state_from_exec_log)
			  else
			  	create sys.make
			  	io.put_string (sys.output.model_state)
			  end
		    -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		    -- At the beginning of the window, append the context state.
		    -- From then onwards, we rely on the log_command feature
		    -- of the output handler
			elseif start_of_window <= line and
			                          line < end_of_window
			then
			  exec (input_file_chunk)
		      if line = start_of_window and
		      			-- if start_of_window = 1, we rely on the
		      			-- output handler to log the intial state
		                start_of_window > 1
		      then
		      	io.put_string (context_state_from_exec_log)
		      end
		      io.put_string (exec_log)
		    -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		    -- ouptuts outside the window are not written to the file.
		    else
			  exec_without_log (input_file_chunk)
			end
			-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		end

	retrieve_context_state_from_exec_log
		local
			last_cmd_pos, last_cmd_end_of_line: INTEGER
		do
			last_cmd_pos := exec_log.substring_index ("->", 1)
			last_cmd_end_of_line := exec_log.index_of ('%N', last_cmd_pos)

			create context_state_from_exec_log.make_from_string (
				exec_log.substring (
					last_cmd_end_of_line + 1, exec_log.count))
		end

	exec (input_cmds: STRING)
			-- Log the execution of 'input_cmds' to 'exec_log'.
		local
			sys : ETF_SOFTWARE_OPERATION
		do
			create sys.make
			create exec_log.make_empty
		    sys.execute (input_cmds, is_init)

		    if sys.error then
		      exec_log := sys.output.error_message + "%N"
		    else
		      exec_log := sys.output.output
		      is_init := false
		    end
		end

	exec_without_log (input_cmds: STRING)
			-- Execute 'input_cmds' without a log.
		local
			sys : ETF_SOFTWARE_OPERATION
		do
			create sys.make
			create exec_log.make_empty
		    sys.execute_without_log (input_cmds)

		    if NOT sys.error then
		      is_init := false
		    end
		end

	man_page : STRING = "[
  new_tracker(
      max_phase_radiation: VALUE ; 
      max_container_radiation: VALUE
  )
  new_phase(
      pid: PID = STRING ; 
      phase_name: STRING ; 
      capacity: INTEGER_64 ; 
      expected_materials: ARRAY[MATERIAL = {glass, metal, plastic, liquid}]
  )
  remove_phase(
      pid: PID = STRING
  )
  new_container(
      cid: CID = STRING ; 
      c: CONTAINER = TUPLE[material: MATERIAL = {glass, metal, plastic, liquid}; radioactivity: VALUE] ; 
      pid: PID = STRING
  )
  remove_container(
      cid: CID = STRING
  )
  move_container(
      cid: CID = STRING ; 
      pid1: PID = STRING ; 
      pid2: PID = STRING
  )
  undo
  redo
]"
 feature -- ETF Version 
	 etf_version : STRING = "1.08 (2017-08-23)"
 end