note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_TRACKER
inherit 
	ETF_NEW_TRACKER_INTERFACE
		redefine new_tracker end
create
	make
feature -- command 
	new_tracker(max_phase_radiation: VALUE ; max_container_radiation: VALUE)
    	do
			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
