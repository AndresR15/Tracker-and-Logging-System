note
	description: "An ETF dummy command."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DUMMY
inherit
	ETF_COMMAND
		redefine
			make
		end
create
	make

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent etf_dummy
			etf_cmd_routine.set_operands (etf_cmd_args)
			out := "etf_dummy"
		end

feature -- routine

	  etf_dummy
    	do
    		etf_cmd_container.on_change.notify ([Current])
    	end
end







