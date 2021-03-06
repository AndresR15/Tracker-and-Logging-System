note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_PHASE

inherit

	ETF_NEW_PHASE_INTERFACE
		redefine
			new_phase
		end

create
	make

feature -- command

	new_phase (pid: STRING; phase_name: STRING; capacity: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
		require else
			new_phase_precond (pid, phase_name, capacity, expected_materials)
		local
			e_command: ERROR
			command: NEW_PHASE
			error: STRING
		do
				-- perform some update on the model state
			model.set_state (model.get_state + 1)
			if model.is_active then
				error := (msg.in_use)
			elseif not model.valid_string (pid) then
				error := (msg.invalid_name_id)
			elseif model.get_phases.has (pid) then
				error := (msg.phase_id_in_use)
			elseif not model.valid_string (phase_name) then
				error := (msg.invalid_name_id)
			elseif capacity <= 0 then
				error := (msg.phase_cap_invalid)
			elseif expected_materials.is_empty then
				error := (msg.material_missing)
			else
				error := msg.ok
			end
			if error /~ msg.ok then
				create e_command.make (error)
				model.get_history.add_to_record (e_command)
				e_command.execute
			else
				create command.make (pid, phase_name, capacity, expected_materials)
				model.get_history.add_to_record (command)
				command.execute
			end
			etf_cmd_container.on_change.notify ([Current])
		end

end
