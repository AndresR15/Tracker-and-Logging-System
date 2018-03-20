note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_NEW_PHASE_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent new_phase(? , ? , ? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {STRING} etf_cmd_args[1] as pid and then attached {STRING} etf_cmd_args[2] as phase_name and then attached {INTEGER_64} etf_cmd_args[3] as capacity and then attached {ARRAY[INTEGER_64]} etf_cmd_args[4] as expected_materials
			then
				out := "new_phase(" + etf_event_argument_out("new_phase", "pid", pid) + "," + etf_event_argument_out("new_phase", "phase_name", phase_name) + "," + etf_event_argument_out("new_phase", "capacity", capacity) + "," + etf_event_argument_out("new_phase", "expected_materials", expected_materials) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	new_phase_precond(pid: STRING ; phase_name: STRING ; capacity: INTEGER_64 ; expected_materials: ARRAY[INTEGER_64]): BOOLEAN
		do  
			Result := 
				         comment ("PID = STRING")
				and then 
				across expected_materials as member all 
					is_material(member.item)
				end
					-- across expected_materials as member all 
					-- 	(( member.item ~ glass ) or else ( member.item ~ metal ) or else ( member.item ~ plastic ) or else ( member.item ~ liquid ))
					-- end
		ensure then  
			Result = 
				         comment ("PID = STRING")
				and then 
				across expected_materials as member all 
					is_material(member.item)
				end
					-- across expected_materials as member all 
					-- 	(( member.item ~ glass ) or else ( member.item ~ metal ) or else ( member.item ~ plastic ) or else ( member.item ~ liquid ))
					-- end
		end 
feature -- command 
	new_phase(pid: STRING ; phase_name: STRING ; capacity: INTEGER_64 ; expected_materials: ARRAY[INTEGER_64])
		require 
			new_phase_precond(pid, phase_name, capacity, expected_materials)
    	deferred
    	end
end
