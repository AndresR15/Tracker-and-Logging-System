note
	description: "Summary description for {PHASE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE_CONTAINER

create
	make

feature {NONE} -- Initialization

	make (init_id: STRING; init_material: INTEGER_64; init_max_rad: VALUE)
			-- Initialization for `Current'.
		do
			id := init_id
			material := init_material
			rad := init_max_rad
		end

feature {NONE} -- Atributes

	id: STRING

	material: INTEGER_64

	rad: VALUE

feature -- Access

	get_id: STRING
		do
			Result := id
		end

	get_material: INTEGER_64
		do
			Result := material
		end

	get_rad: VALUE
		do
			Result := rad
		end

feature -- Commands

feature -- Miscellaneous

feature -- Basic operations

end
