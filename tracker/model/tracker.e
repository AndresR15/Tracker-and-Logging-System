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
		do
			phases := <<>>
		end

feature -- model attributes

	phases: ARRAY [PHASE]

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

feature -- queries

	out: STRING
		do
			create Result.make_from_string ("  ")
		end

end