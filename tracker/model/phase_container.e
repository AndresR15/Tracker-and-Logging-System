note
	description: "Summary description for {PHASE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE_CONTAINER

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

	make (init_id: STRING; init_material: INTEGER_64; init_max_rad: VALUE; init_pid: STRING)
			-- Initialization for `Current'.
		do
			id := init_id
			material := init_material
			rad := init_max_rad
			current_pid := init_pid
		end

feature {NONE} -- Atributes

	id: STRING

	material: INTEGER_64

	rad: VALUE

	current_pid: STRING

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

	get_pid: STRING
		do
			Result := current_pid
		end

feature -- setters

	set_pid (n_pid: STRING)
		-- sets the containers current location (specefied by it's phase_id) to n_pid
		do
			current_pid := n_pid
		ensure
			current_pid = n_pid
		end

feature -- Comparable

	is_less alias "<" (other: PHASE_CONTAINER): BOOLEAN
			--Is current object less than `other'?
		require else
			distinct_id: not (get_id ~ other.get_id)
		do
			if Current = other then
				Result := FALSE
			else
				Result := get_id < other.get_id
			end
		end

	is_equal (other: PHASE_CONTAINER): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			if Current = other then
				Result := TRUE
			else
				Result := (get_id ~ other.get_id) and then (get_rad ~ other.get_rad) and then (get_pid ~ other.get_pid) and then (get_material ~ other.get_material)
			end
		end

feature -- Basic operations

	out: STRING
			-- returns a string representation of the container
		local
			m: MATERIAL
		do
			create Result.make_from_string ("")
			Result.append (id + "->" + current_pid + "->" + m.int_to_material_string (material) + "," + rad.out)
		end

end
