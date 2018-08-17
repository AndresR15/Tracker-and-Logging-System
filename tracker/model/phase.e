note
	description: "Summary description for {PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE

inherit

	COMPARABLE
		undefine
			out
		redefine
			is_equal
		end

	ANY
		undefine
			is_equal
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (init_pid: STRING; phase_name: STRING; cap: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
			-- Initialization for `Current'.
		local
			c: STRING_TABLE [PHASE_CONTAINER]
			z: VALUE
		do
			pid := init_pid
			name := phase_name
			capacity := cap
			expected_mats := expected_materials
			materials_set := material_array_to_set
			create c.make_equal_caseless (10)
			containers := c
			create z.make_from_int (0)
			current_rad := z
		end

feature {PHASE} -- Attributes

	pid: STRING -- identifier

	name: STRING

	capacity: INTEGER_64 -- number of containers PHASE handles

	expected_mats: ARRAY [INTEGER_64] -- subset of materials

	materials_set: ARRAYED_SET [INTEGER_64] -- set of materials

	containers: STRING_TABLE [PHASE_CONTAINER]

	current_rad: VALUE

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

	get_set_mats: ARRAYED_SET [INTEGER_64]
		do
			Result := materials_set
		end

	get_containers: STRING_TABLE [PHASE_CONTAINER]
		do
			Result := containers
		end

	get_current_rad: VALUE
		do
			Result := current_rad
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

	materials_out: STRING
			--outputs the expected materials array
		local
			m: MATERIAL
		do
			create Result.make_from_string ("")
			across
				get_set_mats as set
			loop
				Result.append (m.int_to_material_string (set.item))
				if (not set.is_last) then
					Result.append_character (',')
				end
			end
		end

feature {TRACKER}-- Commands

	add_container (cont: PHASE_CONTAINER)
		require
			capacity_not_exceded: get_capacity >= get_containers.count+1
			cont_not_in_phase: not get_containers.has (cont.get_id)
		do
			get_containers.extend (cont, cont.get_id)
			current_rad := current_rad + cont.get_rad
		ensure
			container_in_phase: get_containers.has (cont.get_id)
			radiation_increased: current_rad = old current_rad + cont.get_rad
		end

	remove_container (cid: STRING)
		require
			container_in_phase: get_containers.has_key (cid)
		do
			if attached containers [cid] as c then
				current_rad := current_rad - c.get_rad
			end
			containers.remove (cid)
		ensure
			container_removed: not containers.has_key (cid)
		end

	material_array_to_set: ARRAYED_SET [INTEGER_64]
		do
			Create Result.make (4)
			across
				expected_mats as cursor
			loop
				Result.extend (cursor.item)
			end
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

	is_equal (other: PHASE): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			if Current = other then
				Result := True
			else
				Result := (pid = other.pid) and then (name ~ other.name) and then (capacity = other.capacity) and then (expected_mats ~ other.expected_mats) and then (containers ~ other.containers)
			end
		end

feature -- Output

	out: STRING
		do
			create Result.make_from_string ("")
			Result.append (pid + "->" + name + ":" + capacity.out)
			Result.append_character (',')
			Result.append_integer (get_containers.count)
			Result.append_character (',')
			Result.append (current_rad.out + ",{" + materials_out + "}")
		end

invariant
	capacity_not_exceeded: capacity >= containers.count
end
