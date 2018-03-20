note
	description: "Summary description for {LIQUID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIQUID

inherit

	MATERIAL

create
	make

feature -- Attributes

	name: STRING

feature {NONE}

	make
		do
			name := "liquid"
		end

end
