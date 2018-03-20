note
	description: "Summary description for {METAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	METAL

inherit

	MATERIAL

create
	make

feature -- Attributes

	name: STRING

feature {NONE}

	make
		do
			name := "metal"
		end

end
