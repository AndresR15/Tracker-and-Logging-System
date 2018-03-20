note
	description: "Summary description for {ETF_TUPLE_PARAM}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TUPLE_PARAM

inherit
	ETF_PRIMITIVE_PARAM_TYPE
		redefine
			out, eiffel_type
		end

create
	make

feature -- Constructor
	make (types : ARRAY[ETF_PARAM_DECL])
		do
			base_types := types
		end

feature -- Attributes
	base_types : ARRAY[ETF_PARAM_DECL]

feature -- Queries
	eiffel_type : STRING
		local
			i: INTEGER
		do
			from
				create Result.make_empty
				Result.append ("TUPLE[")
				i := base_types.lower
			until
				i > base_types.upper
			loop
				Result.append (base_types[i].name)
				Result.append (": ")
				Result.append (base_types[i].type.eiffel_type)
				if i < base_types.upper then
					Result.append ("; ")
				end
				i := i + 1
			end
			Result.append ("]")
		end

	create_clause : STRING
		local
			i: INTEGER
		do
			from
				create Result.make_empty
				Result.append ("create {ETF_TUPLE_PARAM}.make(<<")
				i := base_types.lower
			until
				i > base_types.upper
			loop
				Result.append ("create {ETF_PARAM_DECL}.make(")
				Result.append ("%"" + base_types[i].name + "%"")
				Result.append (", ")
				Result.append (base_types[i].type.create_clause)
				Result.append (")")
				if i < base_types.upper then
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
			from
				create Result.make_empty
				Result.append ("TUPLE[")
				i := base_types.lower
			until
				i > base_types.upper
			loop
				Result.append (base_types[i].name)
				Result.append (": ")
				Result.append (base_types[i].type.out)
				if i < base_types.upper then
					Result.append ("; ")
				end
				i := i + 1
			end
			Result.append ("]")
		end
end


