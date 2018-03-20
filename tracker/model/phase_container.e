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

	make(init_id: STRING; init_material: MATERIAL; init_max_rad: REAL; init_phase_id: STRING)
			-- Initialization for `Current'.
		do
			id := init_id
			material := init_material
			max_rad := init_max_rad
			cur_phase_id := init_phase_id
		end

feature {NONE}-- Atributes
	id: STRING
	material: MATERIAL
	max_rad: REAL
	cur_phase_id: STRING

feature -- Access
	get_id: STRING
		do
			Result := id_key
		end
	get_material: MATERIAL
		do
			Result := material
		end
	get_max_rad: REAL
		do
			Result := max_rad
		end
	get_cur_phase_id: STRING
		do
			Result := cur_phase_id
		end

feature -- Commands
	move_container(new_phase_id: STRING)
		require
			not_current_phase: not (new_phase_id ~ cur_phase_id)
		do

		end
feature -- Removal

feature -- Miscellaneous

feature -- Basic operations

invariant


end
