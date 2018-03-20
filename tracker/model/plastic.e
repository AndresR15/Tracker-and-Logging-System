note
	description: "Summary description for {PLASTIC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	PLASTIC

inherit

	MATERIAL

create
	make

feature -- Attributes

	name: STRING

feature {NONE}

	make
		do
			name := "plastic"
		end

end
