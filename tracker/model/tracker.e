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
			list: STRING_TABLE [PHASE]
			zero: VALUE
		do
			Create zero.make_from_int (0)
			Create list.make_equal_caseless (10)
			phases := list
			error := "ok"
			active := False
			max_phase_rad := zero
			max_cont_rad := zero
		end

feature {TRACKER} -- model attributes

	phases: STRING_TABLE [PHASE]

	error: STRING

	active: BOOLEAN

	max_phase_rad: VALUE

	max_cont_rad: VALUE

feature -- model operations

	new_phase (pid: STRING; phase_name: STRING; capacity: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
		do
		end

	new_tracker (max_p_rad, max_c_rad: VALUE)
		do
			max_phase_rad := max_p_rad
			max_cont_rad := max_c_rad
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

		do


		end

feature -- setters
	set_error(msg: STRING)
		do
			error := msg
		end
feature -- getter
	is_active: BOOLEAN
		do
			Result := active
		end
feature -- error checks

	valid_string (s: STRING): BOOLEAN
			-- does the string start with A-Z, a-z or 0-9?
		do
			Result := (not s.is_empty) and then (s [1].is_alpha_numeric)
		end

	under_capacity (pid: STRING): BOOLEAN
			-- can the phase handle another container?
		require
			phases.has (pid)
		do
			phases.at (pid).get_containers.count < phases.at (pid).get_capacity
		end

--	phase_exists (id: STRING): BOOLEAN
--		do
--			Result := False
--			across
--				phases as i
--			loop
--				if i.item.get_pid ~ id then
--					Result := True
--				end
--			end
--		end

--	has (p_id: STRING): BOOLEAN
--		local
--			i: INTEGER
--		do
--			from
--				Result := False
--				i := phases.lower
--			until
--				Result or else (i > phases.count)
--			loop
--				Result := (phases [i].get_pid ~ p_id)
--				i := i + 1
--			end
--		end

feature -- queries

--	get_phase_by_pid (p_id: STRING): PHASE
--		do
--			from
--				Result := False
--				i := phases.lower
--			until
--				Result or else (i > phases.count)
--			loop
--				Result := (phases [i].get_pid ~ p_id)
--				i := i + 1
--			end
--		end

	out: STRING
		do
			create Result.make_from_string ("  ")
		end

end
