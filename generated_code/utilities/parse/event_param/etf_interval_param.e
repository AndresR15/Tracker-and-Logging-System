note
	description: "Summary description for {ETF_INTERVAL_PARAM}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INTERVAL_PARAM

inherit
	ETF_PRIMITIVE_PARAM_TYPE
	redefine
		out, eiffel_type
	end

create
	make

feature -- Constructor
	make (l, u: INTEGER_64)
		do
			lower := l
			upper := u
		end

feature -- Attributes
	lower, upper: INTEGER_64

feature -- Queries
	eiffel_type : STRING
		do
			Result := "INTEGER_64"
		end

	create_clause : STRING
		do
			Result := "create {ETF_INTERVAL_PARAM}.make(" +
						lower.out + ", " + upper.out + ")"
		end

	out : STRING
		do
			Result := lower.out + " .. " + upper.out
		end
end


