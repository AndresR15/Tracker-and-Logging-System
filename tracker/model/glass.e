note
	description: "Summary description for {GLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GLASS

inherit

	MATERIAL

create
	make

feature -- Attributes

	name: STRING

feature

	make
		once
			name := "glass"
		end

end
