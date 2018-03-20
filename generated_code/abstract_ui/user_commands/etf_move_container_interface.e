note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_MOVE_CONTAINER_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent move_container(? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as cid and then attached {STRING} etf_cmd_args[2] as pid1 and then attached {STRING} etf_cmd_args[3] as pid2
			then
				out := "move_container(" + etf_event_argument_out("move_container", "cid", cid) + "," + etf_event_argument_out("move_container", "pid1", pid1) + "," + etf_event_argument_out("move_container", "pid2", pid2) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	move_container_precond(cid: STRING ; pid1: STRING ; pid2: STRING): BOOLEAN
		do  
			Result := 
				         comment ("CID = STRING")
				and then comment ("PID = STRING")
		ensure then  
			Result = 
				         comment ("CID = STRING")
				and then comment ("PID = STRING")
		end 
feature -- command 
	move_container(cid: STRING ; pid1: STRING ; pid2: STRING)
		require 
			move_container_precond(cid, pid1, pid2)
    	deferred
    	end
end
