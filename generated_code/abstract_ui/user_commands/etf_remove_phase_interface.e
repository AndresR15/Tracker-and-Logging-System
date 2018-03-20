note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_REMOVE_PHASE_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent remove_phase(?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as pid
			then
				out := "remove_phase(" + etf_event_argument_out("remove_phase", "pid", pid) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	remove_phase_precond(pid: STRING): BOOLEAN
		do  
			Result := 
				comment ("PID = STRING")
		ensure then  
			Result = 
				comment ("PID = STRING")
		end 
feature -- command 
	remove_phase(pid: STRING)
		require 
			remove_phase_precond(pid)
    	deferred
    	end
end
