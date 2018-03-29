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
			e_command: ERROR
			command: REMOVE_CONTAINER
			error : STRING
		do
				-- perform some update on the model state
			model.set_state (model.get_state + 1)
			if not model.cid_exists (cid) then
				error := (msg.cont_id_not_in_tracker)
			else
				error := msg.ok
			end

			if error /~ msg.ok then
				create e_command.make (error)
				model.get_history.add_to_record (e_command)
				e_command.execute
			else
				create command.make (cid)
				command.execute
				model.get_history.add_to_record (command)
			end
			etf_cmd_container.on_change.notify ([Current])
		end

end
