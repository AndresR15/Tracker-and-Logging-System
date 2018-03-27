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

	set_pid(n_pid: STRING)
		do
			current_pid := n_pid
		end

feature -- Miscellaneous

feature -- Basic operations

	container_output: STRING
		-- returns a string representation of the container
		local
			m: MATERIAL
		do
			create Result.make_from_string ("")
			Result.append (id + "->" + current_pid)

		end

end
