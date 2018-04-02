note
	description: "Summary description for {REMOVE_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_PHASE

inherit
	COMMAND

create
	make

feature -- Initialization

	make (pid: STRING)
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			p_id := pid
			state := track.get_state
			prev_phase := track.get_phases.at (pid)
			msg := m_a.ok
		end

feature -- Attributes

	p_id: STRING
	prev_phase: detachable PHASE

feature

	execute
		do
			track.remove_phase(p_id)
		end

	undo
		do
			if attached prev_phase as p_p then
				track.new_phase (p_id, p_p.get_name, p_p.get_capacity, p_p.get_mats)
			end
		end

	redo
		do
			execute
		end

end
