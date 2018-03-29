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
			command: NEW_PHASE
		do
				-- perform some update on the model state
			model.set_error (msg.ok)
			model.set_state (model.get_state + 1)
			if model.is_active then
				model.set_error (msg.in_use)
			elseif not model.valid_string (pid) then
				model.set_error (msg.invalid_name_id)
			elseif model.get_phases.has (pid) then
				model.set_error (msg.phase_id_in_use)
			elseif not model.valid_string (phase_name) then
				model.set_error (msg.invalid_name_id)
			elseif capacity < 0 then
				model.set_error (msg.phase_cap_invalid)
			elseif expected_materials.is_empty then
				model.set_error (msg.material_missing)
			else
				create command.make (pid, phase_name, capacity, expected_materials)
				model.get_history.add_to_record (command)
				command.execute
			end
			etf_cmd_container.on_change.notify ([Current])
		end

end
