note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			model.set_state (model.get_state + 1)
			if model.get_history.get_record.isfirst then
						model.set_error (msg.no_undo)
			else
				model.get_history.get_record.item.undo
				model.get_history.get_record.back
			--	model.get_history.get_record.item.execute
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
