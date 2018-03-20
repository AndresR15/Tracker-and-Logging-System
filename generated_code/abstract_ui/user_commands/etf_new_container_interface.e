note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_NEW_CONTAINER_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent new_container(? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as cid and then attached {TUPLE[material: INTEGER_64; radioactivity: VALUE]} etf_cmd_args[2] as c and then attached {STRING} etf_cmd_args[3] as pid
			then
				out := "new_container(" + etf_event_argument_out("new_container", "cid", cid) + "," + etf_event_argument_out("new_container", "c", c) + "," + etf_event_argument_out("new_container", "pid", pid) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	new_container_precond(cid: STRING ; c: TUPLE[material: INTEGER_64; radioactivity: VALUE] ; pid: STRING): BOOLEAN
		do  
			Result := 
				         comment ("CID = STRING")
				and then comment ("PID = STRING")
				and then 
				is_container(c)
					-- (( c.material ~ glass ) or else ( c.material ~ metal ) or else ( c.material ~ plastic ) or else ( c.material ~ liquid ))
		ensure then  
			Result = 
				         comment ("CID = STRING")
				and then comment ("PID = STRING")
				and then 
				is_container(c)
					-- (( c.material ~ glass ) or else ( c.material ~ metal ) or else ( c.material ~ plastic ) or else ( c.material ~ liquid ))
		end 
feature -- command 
	new_container(cid: STRING ; c: TUPLE[material: INTEGER_64; radioactivity: VALUE] ; pid: STRING)
		require 
			new_container_precond(cid, c, pid)
    	deferred
    	end
end
