note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_NEW_TRACKER_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent new_tracker(? , ?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {VALUE} etf_cmd_args[1] as max_phase_radiation and then attached {VALUE} etf_cmd_args[2] as max_container_radiation
			then
				out := "new_tracker(" + etf_event_argument_out("new_tracker", "max_phase_radiation", max_phase_radiation) + "," + etf_event_argument_out("new_tracker", "max_container_radiation", max_container_radiation) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command 
	new_tracker(max_phase_radiation: VALUE ; max_container_radiation: VALUE)
    	deferred
    	end
end
