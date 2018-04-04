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
			if attached track.get_phases.at (pid) as p_p then
				prev_name := p_p.get_name
				prev_cap := p_p.get_capacity
				prev_mats := p_p.get_mats
			else
				prev_name := ""
				prev_cap := 0
				prev_mats := <<>>
			end
			msg := m_a.ok
		end

feature -- Attributes

	p_id: STRING
	prev_name: STRING
	prev_cap: INTEGER_64
	prev_mats: ARRAY[INTEGER_64]

feature

	execute
		do
			track.remove_phase(p_id)
		end

	undo
		do
				track.new_phase (p_id, prev_name, prev_cap, prev_mats)
		end

	redo
		do
			execute
		end

end
