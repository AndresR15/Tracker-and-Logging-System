note
	description: "Summary description for {ETF_ARRAY_PARAM}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ARRAY_PARAM

inherit
	ETF_COMPOSITE_PARAM_TYPE
		redefine
			out, eiffel_type
		end
create
	make

feature -- Constructor
	make (base : ETF_PRIMITIVE_PARAM_TYPE)
		do
			base_type := base
		end

feature -- Attributes
	base_type : ETF_PRIMITIVE_PARAM_TYPE

feature -- Queries
	eiffel_type : STRING
		do
			Result := "ARRAY[" + base_type.eiffel_type + "]"
		end

	create_clause : STRING
		do
			Result := "create {ETF_ARRAY_PARAM}.make (" +
						base_type.create_clause + ")"
		end

	out : STRING
		do
			Result := "ARRAY[" + base_type.out + "]"
		end
end


