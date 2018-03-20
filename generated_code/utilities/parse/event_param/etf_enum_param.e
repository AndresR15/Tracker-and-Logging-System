note
	description: "Summary description for {ETF_ENUM_PARAM}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ENUM_PARAM

inherit
	ETF_PRIMITIVE_PARAM_TYPE
		redefine
			out, eiffel_type
		end

create
	make

feature -- Constructor
	make (list: ARRAY[STRING])
		do
			items := list
		end

feature -- Attributes
	items: ARRAY[STRING]

feature -- Queries
	eiffel_type : STRING
		do
			Result := "INTEGER_64"
		end

	create_clause : STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			Result.append ("create {ETF_ENUM_PARAM}.make(<<")
			from
				i := items.lower
			until
				i > items.upper
			loop
				Result.append ("%"" + items[i] + "%"")
				if i < items.upper then
					Result.append (", ")
				end
				i := i + 1
			end
			Result.append (">>)")
		end

	out : STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			Result.append ("{")
			from
				i := items.lower
			until
				i > items.upper
			loop
				Result.append (items[i])
				if i < items.upper then
					Result.append (", ")
				end
				i := i + 1
			end
			Result.append ("}")
		end
end


