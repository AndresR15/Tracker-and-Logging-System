note
	description: "Summary description for {ETF_PARAM_DECL}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PARAM_DECL

create
	make

feature -- Constructors
	make (n : STRING; t : ETF_PARAM_TYPE)
		do
			name := n
			type := t
		end
		
feature -- Attributes
	name : STRING

	type : ETF_PARAM_TYPE

end


