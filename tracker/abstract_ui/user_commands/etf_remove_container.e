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
		local
			command: REMOVE_CONTAINER
		do
				-- perform some update on the model state
			model.set_error (msg.ok)
			model.set_state (model.get_state + 1)
			if not model.cid_exists (cid) then
				model.store_error (msg.cont_id_not_in_tracker)
			else
				create command.make (cid)
				command.execute
				model.get_history.add_to_record (command)
			end
			etf_cmd_container.on_change.notify ([Current])
		end

end
