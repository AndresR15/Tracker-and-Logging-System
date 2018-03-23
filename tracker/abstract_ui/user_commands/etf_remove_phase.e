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
		do
				-- perform some update on the model state
			model.set_error (msg.ok)
			if model.is_active then
				model.set_error (msg.in_use)
			elseif not model.get_phases.has (pid) then
				model.set_error (msg.phase_id_non_existent)
			end
			model.remove_phase (pid)
			etf_cmd_container.on_change.notify ([Current])
		end

end
