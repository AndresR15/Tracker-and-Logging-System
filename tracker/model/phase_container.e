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

	make (init_id: STRING; init_material: MATERIAL; init_max_rad: VALUE)
			-- Initialization for `Current'.
		do
			id := init_id
			material := init_material
			max_rad := init_max_rad
		end

feature {NONE} -- Atributes

	id: STRING

	material: MATERIAL

	max_rad: VALUE

feature -- Access

	get_id: STRING
		do
			Result := id
		end

	get_material: MATERIAL
		do
			Result := material
		end

	get_max_rad: VALUE
		do
			Result := max_rad
		end

feature -- Commands

feature -- Miscellaneous

feature -- Basic operations

end
