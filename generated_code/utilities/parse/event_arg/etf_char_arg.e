note
	description: "Summary description for {ETF_CHAR_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_CHAR_ARG

inherit
	ETF_PRIMITIVE_ARG
		redefine
			out
		end

create
	make

feature -- Constructor
	make (c: CHARACTER)
	  do
	  	create src_out.make_empty
	    value := c
	  end
	  
feature -- Queries
	value : CHARACTER

feature -- Output
	out : STRING
		do
			Result := "'" + value.out + "'"
		end
end


