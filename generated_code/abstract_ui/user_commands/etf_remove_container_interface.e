note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_REMOVE_CONTAINER_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent remove_container(?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as cid
			then
				out := "remove_container(" + etf_event_argument_out("remove_container", "cid", cid) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	remove_container_precond(cid: STRING): BOOLEAN
		do  
			Result := 
				comment ("CID = STRING")
		ensure then  
			Result = 
				comment ("CID = STRING")
		end 
feature -- command 
	remove_container(cid: STRING)
		require 
			remove_container_precond(cid)
    	deferred
    	end
end
