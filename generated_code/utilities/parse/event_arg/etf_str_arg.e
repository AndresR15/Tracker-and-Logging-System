note
	description: "Summary description for {ETF_STR_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_STR_ARG

inherit
	ETF_PRIMITIVE_ARG
		redefine
			out
		end

create
	make

feature -- Constructor
	make (s: STRING)
	  do
	  	create src_out.make_empty
	    value := s
	  end

feature -- Queries
	value : STRING

feature -- Output
	out : STRING
		do
			Result := "%"" + value.out + "%""
		end
end


