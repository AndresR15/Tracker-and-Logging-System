note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
		redefine redo end
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state
			model.set_state (model.get_state + 1)
			if model.get_history.get_record.isfirst then
				model.set_error (msg.no_redo)
			else
				model.get_history.get_record.item.redo
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
