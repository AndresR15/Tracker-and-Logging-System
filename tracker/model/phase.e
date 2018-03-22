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
			containers := <<>>
		end

feature {NONE} -- Attributes

	pid: STRING -- identifier

	name: STRING

	capacity: INTEGER_64 -- number of containers PHASE handles

	expected_mats: ARRAY [MATERIAL] -- subset of materials

	containers: ARRAY [PHASE_CONTAINER]

feature -- Queries

	get_pid: STRING
		do
			Result := pid
		end

	get_name: STRING
		do
			Result := name
		end

	get_capacity: INTEGER_64
		do
			Result := capacity
		end

	get_mats: ARRAY [MATERIAL]
		do
			Result := expected_mats
		end

	get_containers: ARRAY [PHASE_CONTAINER]
		do
			Result := containers
		end

	container_exists (cid: STRING): BOOLEAN
			-- checks whether a container exists within a phase
		do
			Result := FALSE
			across
				get_containers as c
			loop
				if c.item.get_id ~ cid then
					Result := TRUE
				end
			end
		end

feature -- Commands

end