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
			Create sorted_phases.make
			Create sorted_conts.make
			phases := list
			error := "ok"
			active := False
			state := 0
			max_phase_rad := zero
			max_cont_rad := zero
			create history.make
		end

feature {TRACKER} -- model attributes

	phases: STRING_TABLE [PHASE]

	sorted_phases: SORTED_TWO_WAY_LIST [PHASE]

	sorted_conts: SORTED_TWO_WAY_LIST [PHASE_CONTAINER]

	error: STRING

	active: BOOLEAN

	max_phase_rad: VALUE

	max_cont_rad: VALUE

	state: INTEGER

	history: HISTORY

feature -- model operations

	new_phase (pid: STRING; phase_name: STRING; capacity: INTEGER_64; expected_materials: ARRAY [INTEGER_64])
		require
			valid_pid: valid_string (pid)
			valid_phase_name: valid_string (phase_name)
			positive_capacity: capacity > 0.0
			expected_materials_non_empty: expected_materials.count > 0
		local
			new_p: PHASE
			command: NEW_PHASE
		do
			create new_p.make (pid, phase_name, capacity, expected_materials)
			phases.extend (new_p, pid)
			sorted_phases.extend (new_p)
			state := state + 1
			create command.make (pid, phase_name, capacity, expected_materials)
			history.add_to_record (command)
		end

	new_tracker (max_p_rad, max_c_rad: VALUE)
		require
			positive_values: max_p_rad > 0.0 and then max_c_rad > 0.0
			tracker_not_active: not is_active
		local
			command: NEW_TRACKER
		do
			max_phase_rad := max_p_rad
			max_cont_rad := max_c_rad
			state := state + 1
			create command.make
			history.add_to_record (command)
		end

	new_container (cid: STRING; cont_spec: TUPLE [m: INTEGER_64; rad: VALUE]; pid: STRING)
		local
			cont: PHASE_CONTAINER
			command: NEW_CONTAINER
		do
			create cont.make (cid, cont_spec.m, cont_spec.rad, pid)
			if attached phases [pid] as p then
				p.add_container (cont)

				state := state + 1
				sorted_conts.extend (cont)
				create command.make (cid, cont_spec, pid)
				history.add_to_record (command)
			else
					-- do nothing
			end
		end

	remove_phase (phase_id: STRING)
			-- removes a phase from the tracker
		require
			phase_exists: get_phases.has (phase_id)
		local
			command: REMOVE_PHASE
		do
			phases.remove (phase_id)
			state := state + 1
			create command.make (phase_id)
			history.add_to_record (command)
		ensure
			phase_removed: not (phases.has_key (phase_id))
		end

	remove_container (cid: STRING)
			-- removes a container from the tracker
		local
			cur_phase: PHASE
			cur_cont: PHASE_CONTAINER
			command: REMOVE_CONTAINER
		do
			cur_phase := get_phase_containing_cid (cid)
			cur_cont := get_container (cid)
			if attached cur_phase as p and then attached cur_cont as c then
				sorted_conts.prune_all (c)
				p.remove_container (cid)
				state := state + 1
				create command.make (cid)
				history.add_to_record (command)
			else
					-- do nothing
			end
		end

	move_container (cid: STRING; pid1: STRING; pid2: STRING)
			-- moves a container from a source phase to a target phase
		local
			temp_cont: PHASE_CONTAINER
			command: MOVE_CONTAINER
		do
			if attached get_container (cid) as cont and then attached phases [pid1] as p1 and then attached phases [pid2] as p2 then
				temp_cont := cont
				p1.remove_container (cid)
				p2.add_container (temp_cont)
				state := state + 1
				create command.make (cid, pid1, pid2)
				history.add_to_record (command)
			end
		ensure
			container_exists: cid_exists (cid)
			cid_in_phase_attached: attached get_phase_containing_cid (cid) as pc
			cont_is_in_target_phase: pc.get_pid ~ pid2
		end

	store_error (new_msg: STRING)
			-- stores the state of error into history
		local
			e: ERROR
		do
			error := new_msg
			state := state + 1
			create e.make (error)
			history.add_to_record (e)
		end

feature -- setters

	set_error (msg: STRING)
		do
			error := msg
		end

	set_state (new_state: INTEGER)
		do
			state := new_state
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
			get_phases.has (pid)
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

	mats_not_in_phase (mat: INTEGER_64; pid: STRING): BOOLEAN
			-- does the phase expect this container material?
		do
			if attached phases [pid] as p then
				across
					p.get_mats as cm
				loop
					if cm.item ~ mat then
						Result := FALSE
					else
						Result := TRUE
					end
				end
			end
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

	cid_exists (cid: STRING): BOOLEAN
		do
			Result := False
			across
				phases as p
			loop
				Result := Result or else (p.item.get_containers.has (cid))
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
			msg : MESSAGES_ACCESS
		do
			create Result.make_from_string ("  state ")
			Result.append_integer (state)
			Result.append (" " + error)
			if (error = msg.ok) then
				Result.append("%N  max_phase_radiation: ")
				Result.append (max_phase_rad.out)
				Result.append (",%Nmax_container_radiation: ")
				Result.append (max_cont_rad.out)

				Result.append ("%N  phases: pid->name:capacity,count,radiation")
				if not sorted_phases.is_empty then
					Result.append ("%N")
					create stwl_p.make(sorted_phases)
					Result.append (stwl_p.out)
				end

				Result.append ("  containers: cid->pid->material,radioactivity")
				if not sorted_conts.is_empty then
					Result.append ("%N")
					create stwl_c.make(sorted_conts)
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



end
