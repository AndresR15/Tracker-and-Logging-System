note
	description: "Summary description for {ETF_INT_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INT_ARG

inherit
	ETF_PRIMITIVE_ARG
	redefine
		out
	end

create
	make

feature -- Constructor
	make(i : INTEGER_64)
	  do
	  	create src_out.make_empty
	    value := i
	  end

feature -- Queries
	value : INTEGER_64

feature -- Output
	out : STRING
		do
			Result := value.out
		end
end


