note
	description: "Summary description for {MATERIAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MATERIAL

create
	make

feature -- Attributes

	name: STRING

feature {NONE}

	make (int: INTEGER_64)
		do
			inspect int
			when 1 then
				name := "glass"
			when 2 then
				name := "metal"
			when 3 then
				name := "plastic"
			when 4 then
				name := "liquid"
			end
		end
end
