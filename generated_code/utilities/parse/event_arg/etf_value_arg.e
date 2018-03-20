note
	description: "Summary description for {ETF_VALUE_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_VALUE_ARG

inherit
	ETF_PRIMITIVE_ARG
	redefine
		out
	end

create
	make

feature -- Constructor
	make(s : STRING)
	  do
	  	src_out := s
	    create value.make_from_string (s)
	  end

feature -- Queries
	value : VALUE

feature -- Output
	out : STRING
		do
			Result := value.precise_out
		end
end


