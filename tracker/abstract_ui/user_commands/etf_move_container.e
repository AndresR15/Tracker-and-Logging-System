note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_CONTAINER

inherit

	ETF_MOVE_CONTAINER_INTERFACE
		redefine
			move_container
		end

create
	make

feature -- command

	move_container (cid: STRING; pid1: STRING; pid2: STRING)
		require else
			move_container_precond (cid, pid1, pid2)
		do
			if attached model.get_phase_containing_cid (cid) as phase and attached model.get_container (cid) as cont then

					-- perform some update on the model state
				model.set_error (msg.ok)
				if not model.cid_exists (cid) then
					model.set_error (msg.cont_id_not_in_tracker)
				elseif pid1 ~ pid2 then
					model.set_error (msg.diff_phase_id)
				elseif not model.get_phases.has (pid2) and model.get_phases.has (pid1) then
					model.set_error (msg.phase_id_non_existent)
				elseif phase.get_pid /~ pid1 then
					model.set_error (msg.cont_id_not_in_source)
				elseif not model.under_capacity (pid2) then
					model.set_error (msg.cont_exceeds_cap)
				elseif model.cont_gt_max_phase_rad (cont.get_rad, pid2) then
					model.set_error (msg.cont_exceeds_rad)
				elseif model.mats_not_in_phase (cont.get_material, pid2) then
					model.set_error (msg.material_unexpected)
				else
					model.move_container (cid, pid1, pid2)
				end
				etf_cmd_container.on_change.notify ([Current])
			else
					-- do nothing
			end
		end

end
