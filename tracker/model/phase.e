note
	description: "Summary description for {PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE

inherit

	COMPARABLE
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (init_pid: STRING; phase_name: STRING; cap: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
			-- Initialization for `Current'.
		local
			c: STRING_TABLE [PHASE_CONTAINER]
		do
			pid := init_pid
			name := phase_name
			capacity := cap
			expected_mats := expected_materials
			create c.make_equal_caseless (10)
			containers := c
		end

feature {PHASE} -- Attributes

	pid: STRING -- identifier

	name: STRING

	capacity: INTEGER_64 -- number of containers PHASE handles

	expected_mats: ARRAY [INTEGER_64] -- subset of materials

	containers: STRING_TABLE [PHASE_CONTAINER]

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

	get_mats: ARRAY [INTEGER_64]
		do
			Result := expected_mats
		end

	get_containers: STRING_TABLE [PHASE_CONTAINER]
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
	add_container (cont: PHASE_CONTAINER)
		do
			get_containers.extend (cont, cont.get_id)
		end

	remove_container (cid: STRING)
		require
			container_in_phase: get_containers.has_key (cid)
		do
			containers.remove (cid)
		ensure
			container_removed: not containers.has_key(cid)
		end

feature -- compare

	is_less alias "<" (other: PHASE): BOOLEAN
			-- Is current object less than `other'?
		require else
			distinct_pid: not (get_pid ~ other.get_pid)
		do
			if Current = other then
				Result := False
			elseif get_pid < other.get_pid then
				Result := True
			end
		end

	is_equal(other: PHASE): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			if Current = other then
				Result := True
			else
				Result := (pid = other.pid) and then (name ~ other.name)
				and then (capacity = other.capacity) and then (expected_mats ~ other.expected_mats)
				and then (containers ~ other.containers)
			end
		end

end
