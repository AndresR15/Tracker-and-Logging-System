note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_CONTAINER
inherit
	ETF_NEW_CONTAINER_INTERFACE
		redefine new_container end
create
	make
feature -- command
	new_container(cid: STRING ; c: TUPLE[material: INTEGER_64; radioactivity: VALUE] ; pid: STRING)
		require else
			new_container_precond(cid, c, pid)
    	do
			-- perform some update on the model state
			model.set_error (msg.ok)
					if not model.valid_string (cid) then
						model.set_error (msg.invalid_name_id)
					elseif model.cid_exists (cid) then
						model.set_error (msg.cont_id_in_tracker)
					elseif not model.valid_string (pid) then
						model.set_error (msg.invalid_name_id)
					elseif not model.get_phases.has (pid) then
						model.set_error (msg.phase_id_non_existent)
					elseif (c.radioactivity < 0.0) then
						model.set_error (msg.cont_rad_non_negative)
					elseif not model.under_capacity(pid) then
						model.set_error (msg.cont_exceeds_cap)
					elseif c.radioactivity > model.get_max_cont_rad then
						model.set_error (msg.cont_exceeds_rad_cap)
					end
			model.new_container(cid, c, pid)
			etf_cmd_container.on_change.notify ([Current])
    	end

end
