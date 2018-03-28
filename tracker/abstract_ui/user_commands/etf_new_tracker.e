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
		do
				-- perform some update on the model state
			model.set_error (msg.ok)
			model.set_state (model.get_state + 1)
			if model.is_active then
				model.set_error (msg.in_use)
			elseif (max_phase_radiation < 0.0) then
				model.set_error (msg.non_neg_phase_rad)
			elseif (max_container_radiation < 0.0) then
				model.set_error (msg.non_neg_container_rad)
			elseif (max_container_radiation > max_phase_radiation) then
				model.set_error (msg.container_lt_phase)
			else

				model.new_tracker (max_phase_radiation, max_container_radiation)
			end
			etf_cmd_container.on_change.notify ([Current])
		end

end
