note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_CONTAINER

inherit

	ETF_NEW_CONTAINER_INTERFACE
		redefine
			new_container
		end

create
	make

feature -- command

	new_container (cid: STRING; c: TUPLE [material: INTEGER_64; radioactivity: VALUE]; pid: STRING)
		require else
			new_container_precond (cid, c, pid)
		local
			command: NEW_CONTAINER
		do
				-- perform some update on the model state
			model.set_error (msg.ok)
			model.set_state (model.get_state + 1)
			if not model.valid_string (cid) then
				model.store_error (msg.invalid_name_id)
			elseif model.cid_exists (cid) then
				model.store_error (msg.cont_id_in_tracker)
			elseif not model.valid_string (pid) then
				model.store_error (msg.invalid_name_id)
			elseif not model.get_phases.has (pid) then
				model.store_error (msg.phase_id_non_existent)
			elseif (c.radioactivity < 0.0) then
				model.store_error (msg.cont_rad_non_negative)
			elseif not model.under_capacity (pid) then
				model.store_error (msg.cont_exceeds_cap)
			elseif c.radioactivity > model.get_max_cont_rad then
				model.store_error (msg.cont_exceeds_rad_cap)
			elseif model.cont_gt_max_phase_rad (c.radioactivity, pid) then
				model.store_error (msg.cont_exceeds_rad)
			elseif not model.phase_expects_mat (c.material, pid) then
				model.store_error (msg.material_unexpected)
			else
				create command.make (cid, c, pid)
				model.get_history.add_to_record (command)
				command.execute
			end

			etf_cmd_container.on_change.notify ([Current])
		end

end
