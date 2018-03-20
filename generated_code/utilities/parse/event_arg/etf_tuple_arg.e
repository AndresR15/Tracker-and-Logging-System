note
	description: "Summary description for {ETF_TUPLE_ARG}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TUPLE_ARG

inherit
	ETF_PRIMITIVE_ARG
	redefine
		out
	end

create
	make

feature -- Constructor
	make (v : ARRAY[ETF_EVT_ARG])
		do
			create src_out.make_empty
			value := v
		end

feature -- Queries
	value : ARRAY[ETF_EVT_ARG]

feature -- Output
	out : STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			Result.append ("[")
			from
				i := value.lower
			until
				i > value.upper
			loop
				if NOT value[i].src_out.is_empty then
					Result.append (value[i].src_out)
				else
					Result.append (value[i].out)
				end
				if i < value.upper then
					Result.append (", ")
				end
				i := i + 1
			end
			Result.append ("]")
		end
end


