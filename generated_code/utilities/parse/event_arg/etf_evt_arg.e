note
	description: "Summary description for {ETF_EVT_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_EVT_ARG

feature -- Queries
	src_out : STRING
		-- Original representation of the argument in the input file.
		-- e.g., for enumerated type argument src_out = 'on'

	set_src_out (s: STRING)
		do
			src_out := s
		end
end


