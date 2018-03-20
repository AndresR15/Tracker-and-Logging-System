note
	description: "Summary description for {ETF_BOOL_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_BOOL_ARG

inherit
	ETF_PRIMITIVE_ARG
		redefine
			out
		end

create
	make

feature -- Constructor
	make (b: BOOLEAN)
	  do
	  	create src_out.make_empty
	    value := b
	  end

feature -- Queries
	value : BOOLEAN

feature -- Output
	out : STRING
		do
			Result := value.out
		end
end


