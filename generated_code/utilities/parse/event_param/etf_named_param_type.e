note
	description: "Summary description for {ETF_NAMED_PARAM_TYPE}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NAMED_PARAM_TYPE

inherit
	ETF_COMPOSITE_PARAM_TYPE
		redefine
			out, eiffel_type
		end

	ETF_PRIMITIVE_PARAM_TYPE
		redefine
			out, eiffel_type
		end

create
	make

feature -- Contructor
	make (n: STRING; t: ETF_PARAM_TYPE)
		do
			name := n
			type := t
		end

feature -- Attributes
	name: STRING

	type: ETF_PARAM_TYPE

feature -- Queries
	eiffel_type : STRING
		do
			Result := type.eiffel_type
		end

	create_clause : STRING
		do
			Result := "create {ETF_NAMED_PARAM_TYPE}.make(" +
						"%"" + name + "%"" + ", " + type.create_clause + ")"
		end

	out : STRING
		do
			Result := name + " = " + type.out
		end
end


