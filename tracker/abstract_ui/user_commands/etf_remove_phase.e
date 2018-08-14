note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REMOVE_PHASE

inherit

	ETF_REMOVE_PHASE_INTERFACE
		redefine
			remove_phase
		end

create
	make

feature -- command

	remove_phase (pid: STRING)
		require else
			remove_phase_precond (pid)
		local
			e_command: ERROR
			command: REMOVE_PHASE
			error: STRING
		do
				-- perform some update on the model state
			model.set_state (model.get_state + 1)
			if model.is_active then
				error := (msg.in_use)
			elseif not model.get_phases.has (pid) then
				error := (msg.phase_id_non_existent)
			else
				error := msg.ok
			end
			if error /~ msg.ok then
				create e_command.make (error)
				e_command.execute
				model.get_history.add_to_record (e_command)
			else
				create command.make (pid)
				command.execute
				model.get_history.add_to_record (command)
			end
			etf_cmd_container.on_change.notify ([Current])
		end

end
