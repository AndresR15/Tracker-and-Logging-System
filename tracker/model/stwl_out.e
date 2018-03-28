note
	description: "Summary description for {STWL_OUT}."
	author: "Andres Rojas"

class
	STWL_OUT [G -> attached COMPARABLE]

inherit

	ANY
		redefine
			out
		end

create
	make

feature {STWL_OUT} -- Attributes

	list: SORTED_TWO_WAY_LIST [G]

feature -- Constructor

	make (new_list: like list)
		do
			list := new_list
		end

feature -- Output

	out: STRING
		do
			create Result.make_from_string ("")
			across
				list as cursor
			loop
				if cursor.is_last then
						--corrects oracle output inconsistency
					Result.append ("    " + cursor.item.out)
				else
					Result.append ("    " + cursor.item.out + "%N")
				end

			end
		end

end
