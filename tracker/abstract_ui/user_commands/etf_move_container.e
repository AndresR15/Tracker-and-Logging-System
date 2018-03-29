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
		local
			e_command: ERROR
			command: MOVE_CONTAINER
			error: STRING
		do
			if attached model.get_phase_containing_cid (cid) as phase and attached model.get_container (cid) as cont then
					-- perform some update on the model state
				model.set_state (model.get_state + 1)
				if not model.cid_exists (cid) then
					error :=  (msg.cont_id_not_in_tracker)
				elseif pid1 ~ pid2 then
					error :=  (msg.diff_phase_id)
				elseif not model.get_phases.has (pid2) and model.get_phases.has (pid1) then
					error :=  (msg.phase_id_non_existent)
				elseif phase.get_pid /~ pid1 then
					error :=  (msg.cont_id_not_in_source)
				elseif not model.under_capacity (pid2) then
					error :=  (msg.cont_exceeds_cap)
				elseif model.cont_gt_max_phase_rad (cont.get_rad, pid2) then
					error :=  (msg.cont_exceeds_rad)
				elseif not model.phase_expects_mat (cont.get_material, pid2) then
					error := (msg.material_unexpected)
				else
					error := msg.ok
				end

				if error /~ msg.ok then
					create e_command.make (error)
					model.get_history.add_to_record (e_command)
					e_command.execute
				else
					create command.make (cid, pid1, pid2)
					model.get_history.add_to_record (command)
					command.execute
				end

				etf_cmd_container.on_change.notify ([Current])
			end
		end

end
