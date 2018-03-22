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
			Create ht.make (5)
			phases := ht
		end

feature {NONE} -- model attributes

	phases: HASH_TABLE[STRING_8, PHASE]

feature -- model operations

	new_phase (pid: STRING; phase_name: STRING; capacity: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
		do
		end

	int_to_mat (int: INTEGER_64): MATERIAL
			-- convert INTEGER_64 to a MATERIAL
		require
			invalid_mat: int > 0 and int < 5
		local
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

feature -- commands

	remove_phase (phase_id: STRING)
		require
			phase_exists: phase_exists(phase_id)
		do
			phases.prune (phase_id)
		end

feature -- error checks

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
