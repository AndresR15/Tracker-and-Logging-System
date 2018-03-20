note
	description: "Summary description for {PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE

create
	make

feature {NONE} -- Initialization

	make (init_pid: STRING; phase_name: STRING; cap: INTEGER_64; expected_materials: ARRAY [MATERIAL])
			-- Initialization for `Current'.
		do
			pid := init_pid
			name := phase_name
			capacity := cap
			expected_mats := expected_materials
		end

feature {NONE} -- Attributes

	pid: STRING -- identifier

	name: STRING

	capacity: INTEGER_64 -- number of containers PHASE handles

	expected_mats: ARRAY [MATERIAL] -- subset of materials

feature -- Queries

	get_pid
		do
			Result := pid
		end

	get_name
		do
			Result := name
		end

	get_capacity
		do
			Result := capacity
		end

	get_mats
		do
			Result := expected_mats
		end

feature -- Commands

end
