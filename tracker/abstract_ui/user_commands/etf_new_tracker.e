note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_TRACKER

inherit

	ETF_NEW_TRACKER_INTERFACE
		redefine
			new_tracker
		end

create
	make

feature -- command

	new_tracker (max_phase_radiation: VALUE; max_container_radiation: VALUE)
		local
			e_command: ERROR
			command: NEW_TRACKER
			error: STRING
		do
				-- perform some update on the model state
			model.set_state (model.get_state + 1)
			if model.is_active then
				error := (msg.in_use)
			elseif (max_phase_radiation < 0.0) then
				error := (msg.non_neg_phase_rad)
			elseif (max_container_radiation < 0.0) then
				error := (msg.non_neg_container_rad)
			elseif (max_container_radiation > max_phase_radiation) then
				error := (msg.container_lt_phase)
			else
				error := msg.ok
			end

			if error /~ msg.ok then
				create e_command.make (error)
				model.get_history.add_to_record (e_command)
				e_command.execute
			else
				create command.make (max_phase_radiation, max_container_radiation)
				model.get_history.reset_record_and_append(command)
				command.execute
			end
			etf_cmd_container.on_change.notify ([Current])
		end
end
