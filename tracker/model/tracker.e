note
	description: "A default business model."
	author: "Andres Rojas and Victor Vavan"

class
	TRACKER

inherit

	ANY
		redefine
			out
		end

create {TRACKER_ACCESS}
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			ht: HASH_TABLE[STRING_8, PHASE]
		do
			active := FALSE
			max_phase_rad := 0
			max_cont_rad := 0
			Create ht.make (5)
			phases := ht
		end

feature {TRACKER} -- model attributes

	phases: HASH_TABLE[STRING_8, PHASE]

	error: STRING

	active: BOOLEAN

	max_phase_rad: VALUE

	max_cont_rad: VALUE

feature -- model operations

	new_phase (pid: STRING; phase_name: STRING; capacity: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
		do
		end

	int_to_mat (int: INTEGER_64): MATERIAL
			-- convert INTEGER_64 to a MATERIAL
		require
			invalid_mat: int > 0 and int < 5
		locals
			m: MATERIAL
		do
			create m.make (int)
			Result := m
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- Setters

	set_error (new_error: STRING)
		do
			error := new_error
		end

feature -- Getters

	get_max_phase: VALUE
		do
			Result := max_phase_rad
		end

	get_max_cont: VALUE
		do
			Result := max_cont_rad
		end

feature -- Command

	new_tracker (max_phase: VALUE; max_cont: VALUE)
		do
			active := TRUE
			max_phase_rad := max_phase
			max_cont_rad := max_cont
		end

	remove_phase (phase_id: STRING)
		require
			phase_exists: phase_exists(phase_id)
		do
			phases.prune (phase_id)
		end


feature -- Error Checking

	phase_exists (id: STRING): BOOLEAN
		do
			Result := False
			across
				phases as i
			loop
				if i.item.get_pid ~ id then
					Result := True
				end
			end
		end

feature -- queries

	out: STRING
		do
			create Result.make_from_string ("  ")
		end

end
