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

feature {ES_TEST} -- Initialization

	make
			-- Initialization for `Current'.
		local
			list: STRING_TABLE [PHASE]
			zero: VALUE
			er_msg: MESSAGES_ACCESS
			nt: NEW_TRACKER
		do
			Create zero.make_from_int (0)
			Create list.make_equal_caseless (10)
			Create sorted_phases.make
			Create sorted_conts.make
			phases := list
			error := er_msg.ok
			active := False
			state := 0
			cursor_state := 0
			max_phase_rad := zero
			max_cont_rad := zero
			create history.make
			create nt.make_init (max_phase_rad, max_cont_rad)
			history.add_to_record (nt)
		end

feature {TRACKER} -- model attributes

	phases: STRING_TABLE [PHASE]

	sorted_phases: SORTED_TWO_WAY_LIST [PHASE]

	sorted_conts: SORTED_TWO_WAY_LIST [PHASE_CONTAINER]

	error: STRING

	active: BOOLEAN

	max_phase_rad: VALUE

	max_cont_rad: VALUE

	state, cursor_state: INTEGER

	history: HISTORY

	msg: MESSAGES_ACCESS

feature {COMMAND, ES_TEST} -- model operations

	new_phase (pid: STRING; phase_name: STRING; capacity: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
		require
			tracker_not_active: not is_active
			valid_pid: valid_string (pid)
			pid_not_in_system: not get_phases.has (pid)
			valid_phase_name: valid_string (phase_name)
			positive_capacity: capacity > 0.0
			expected_materials_non_empty: expected_materials.count > 0
		local
			new_p: PHASE
		do
			create new_p.make (pid, phase_name, capacity, expected_materials)
			phases.extend (new_p, pid)
			sorted_phases.extend (new_p)
			set_error (msg.ok)
		ensure
			phase_added_to_tracker: get_phases.has (pid)
		end

	new_tracker (max_p_rad, max_c_rad: VALUE)
		require
			positive_values: max_p_rad >= 0.0 and then max_c_rad >= 0.0
			max_container_rad_less_than_max_phase_rad: max_p_rad >= max_c_rad
			tracker_not_active: not is_active
		do
			max_phase_rad := max_p_rad
			max_cont_rad := max_c_rad
			set_error (msg.ok)
		ensure
			max_radiation_updated: max_phase_rad = max_p_rad and max_cont_rad = max_c_rad
		end

	new_container (cid: STRING; cont_spec: TUPLE [m: INTEGER_64; rad: VALUE]; pid: STRING)
		require
			valid_cid: valid_string (cid)
			phase_exists: get_phases.has (pid)
			phase_not_full: under_capacity (pid)
			rad_within_threshold: cont_spec.rad <= get_max_cont_rad
			cont_not_in_use: not cid_exists (cid)
			phase_max_rad_not_exceaded: not cont_gt_max_phase_rad (cont_spec.rad, pid)
			phase_expects_matterial: phase_expects_mat (cont_spec.m, pid)

		local
			cont: PHASE_CONTAINER
		do
			create cont.make (cid, cont_spec.m, cont_spec.rad, pid)
			if attached phases [pid] as p then
				p.add_container (cont)
				sorted_conts.extend (cont)
				set_error (msg.ok)
			end
		end

	remove_phase (phase_id: STRING)
			-- removes a phase from the tracker
		require
			phase_exists: get_phases.has (phase_id)
			tracker_not_active: not is_active
		do
			if attached phases [phase_id] as p then
				sorted_phases.prune_all (p)
			end
			phases.remove (phase_id)
			set_error (msg.ok)
		ensure
			phase_removed: not (phases.has_key (phase_id))
			-- reomved fro sorted phases
		end

	remove_container (cid: STRING)
			-- removes a container from the tracker
		require
			container_exists: cid_exists(cid)
		local
			cur_phase: PHASE
			cur_cont: PHASE_CONTAINER
		do
			cur_phase := get_phase_containing_cid (cid)
			cur_cont := get_container (cid)
			if attached cur_phase as p and then attached cur_cont as c then
				sorted_conts.prune_all (c)
				p.remove_container (cid)
			end
			set_error (msg.ok)
		end

	move_container (cid: STRING; pid1: STRING; pid2: STRING)
			-- moves a container from a source phase to a target phase
		require
			container_exists: cid_exists(cid)
			phase1_exists: get_phases.has(pid1)
			phase2_exists: get_phases.has(pid2)
			phases_are_destinct: not (pid1 = pid2)

		local
			temp_cont: PHASE_CONTAINER
		do
			if attached get_container (cid) as cont and then attached phases [pid1] as p1 and then attached phases [pid2] as p2 then
				temp_cont := cont
				p1.remove_container (cid)
				p2.add_container (temp_cont)
				cont.set_pid (pid2)
			end
			set_error (msg.ok)
		ensure
			container_exists: cid_exists (cid)
		end

	store_error (new_msg: STRING)
			-- stores the state of error into history
		local
			e: ERROR
		do
			error := new_msg
			create e.make (error)
			history.add_to_record (e)
		end

feature -- setters

	set_error (init_msg: STRING)
		do
			error := init_msg
		end

	set_state (new_state: INTEGER)
			-- sets both the state and the cursor state to state
		do
			state := new_state
			set_cursor_state (state)
		end

	set_cursor_state (cur_state: INTEGER)

		do
			cursor_state := cur_state
		end

feature -- getter

	get_phases: STRING_TABLE [PHASE]
		do
			Result := phases
		end

	get_history: HISTORY
		do
			Result := history
		end

	get_state: INTEGER
		do
			Result := state
		end

	get_cursor_state: INTEGER
		do
			Result := cursor_state
		end

	get_max_cont_rad: VALUE
		do
			Result := max_cont_rad
		end

	get_max_phase_rad: VALUE
		do
			Result := max_phase_rad
		end

feature -- error checks

	is_active: BOOLEAN
			-- are there any containers in the system
		do
			Result := sorted_conts.count > 0
		end

	valid_string (s: STRING): BOOLEAN
			-- does the string start with A-Z, a-z or 0-9?
		do
			Result := (not s.is_empty) and then (s [1].is_alpha_numeric)
		end

	under_capacity (pid: STRING): BOOLEAN
			-- can the phase handle another container?
		require
			phase_exists: get_phases.has (pid)
		do
			if attached get_phases.at (pid) as p and attached get_phases.at (pid) as gp then
				Result := (p.get_containers.count) < (gp.get_capacity)
			else
			end
		end

	cont_gt_max_phase_rad (rad: VALUE; pid: STRING): BOOLEAN
			-- is the total container radiation greater than the maximum phase radiation?
		local
			sum: VALUE
		do
			create sum.make_from_int (0)
			if attached phases [pid] as conts then
				across
					conts.get_containers as cc
				loop
					sum := sum + cc.item.get_rad
				end
				sum := sum + rad
				if sum > max_phase_rad then
					Result := TRUE
				else
					Result := FALSE
				end
			end
		end

	phase_expects_mat (mat: INTEGER_64; pid: STRING): BOOLEAN
			-- does the phase expect this container material?
		do
			Result := FALSE
			if attached phases [pid] as p then
				across
					p.get_mats as cm
				loop
					if cm.item = mat then
						Result := TRUE
					end
				end
			end
		end

	cid_exists (cid: STRING): BOOLEAN
		do
			Result := False
			across
				phases as p
			loop
				Result := Result or else (p.item.get_containers.has (cid))
			end
		end

	max_cur_rad_over_all_phases: VALUE
		local
			zero: VALUE
		do
			Create zero.make_from_int (0)
			Result := zero
			across
				phases as p
			loop
				if Result < p.item.get_current_rad then
					Result := p.item.get_current_rad
				end
			end
		end

	max_cont_rad_over_all_containers: VALUE
		local
			zero: VALUE
		do
			Create zero.make_from_int (0)
			Result := zero
			across
				sorted_conts as c
			loop
				if Result < c.item.get_rad then
					Result := c.item.get_rad
				end
			end
		end



feature -- queries

	get_phase_containing_cid (cid: STRING): detachable PHASE
		do
			Result := void
			across
				phases as cursor
			loop
				if cursor.item.get_containers.has (cid) then
					Result := cursor.item
				end
			end
		end

	get_container (cid: STRING): detachable PHASE_CONTAINER
		do
			across
				phases as cursor
			loop
				if cursor.item.get_containers.has (cid) then
					Result := cursor.item.get_containers [cid]
				end
			end
		end

	out: STRING
		local
			stwl_c: STWL_OUT [PHASE_CONTAINER]
			stwl_p: STWL_OUT [PHASE]
			er_msg: MESSAGES_ACCESS
		do
			create Result.make_from_string ("  state ")
			Result.append_integer (state)
			if cursor_state /= state then
				Result.append (" (to ")
				Result.append_integer (cursor_state)
				Result.append (")")
			end
			Result.append (" " + error)
			if (error = er_msg.ok) then
				Result.append ("%N  max_phase_radiation: ")
				Result.append (max_phase_rad.out)
				Result.append (", max_container_radiation: ")
				Result.append (max_cont_rad.out)
				Result.append ("%N  phases: pid->name:capacity,count,radiation")
				if not sorted_phases.is_empty then
					Result.append ("%N")
					create stwl_p.make (sorted_phases)
					Result.append (stwl_p.out)
				end
				Result.append ("%N  containers: cid->pid->material,radioactivity")
				if not sorted_conts.is_empty then
					Result.append ("%N")
					create stwl_c.make (sorted_conts)
					Result.append (stwl_c.out)
				end
			end
		end

feature -- misc

	reset
			-- Reset model state.
		do
			make
		end

invariant
	no_phase_over_max_phase_rad: max_cur_rad_over_all_phases <= max_phase_rad
	no_conts_over_max_cont_rad: max_cont_rad_over_all_containers <= max_cont_rad

end
