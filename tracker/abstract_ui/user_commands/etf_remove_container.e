note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REMOVE_CONTAINER

inherit

	ETF_REMOVE_CONTAINER_INTERFACE
		redefine
			remove_container
		end

create
	make

feature -- command

	remove_container (cid: STRING)
		require else
			remove_container_precond (cid)
		do
				-- perform some update on the model state
			model.set_error (msg.ok)
			if not model.cid_exists (cid) then
				model.set_error (msg.cont_id_not_in_tracker)
			end
			model.remove_container (cid)
			etf_cmd_container.on_change.notify ([Current])
		end

end
