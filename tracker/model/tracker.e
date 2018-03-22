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

	new_container(cid: STRING; cont_spec: TUPLE [m: INTEGER_64; rad: VALUE]; pid: STRING)
		local
			mat: MATERIAL
			cont: PHASE_CONTAINER
		do
			create mat.make (cont_spec.m)
			create cont.make (cid, mat, cont_spec.rad)
			if attached phases[pid] as p then
				p.add_container (cont)
			else
				-- do nothing
			end

		end

	remove_phase (phase_id: STRING)
		require
			phase_exists: get_phases.has (phase_id)
		do
			phases.remove (phase_id)
		end

	remove_container (cid: STRING)
		local
			cont: PHASE_CONTAINER
		do
			cont := get_container(cid)

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
	get_phases: STRING_TABLE [PHASE]
		do
			Result := phases
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
			get_phases.has (pid)
		do
			if attached get_phases.at (pid) as p and attached get_phases.at (pid) as gp then
				Result := (p.get_containers.count) < (gp.get_capacity)
			else
			end

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

	get_max_cont_rad: VALUE
		do
			Result := max_cont_rad
		end

	get_max_phase_rad: VALUE
		do
			Result := max_phase_rad
		end

feature -- error checks
	cid_exists(cid: STRING): BOOLEAN
		do
			Result := False
			across phases as p loop
				Result := Result or else (p.item.get_containers.has (cid))
			end
		end

feature -- queries
	get_container(cid: STRING): detachable PHASE_CONTAINER
		do
			Result := void
			across phases as cursor loop
				if cursor.item.get_containers.has (cid) then
					Result := cursor.item.get_containers.at(cid)
				end
			end
		end

	out: STRING
		do
			create Result.make_from_string ("  ")
		end

feature -- misc
	reset
			-- Reset model state.
		do
			make
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
end
