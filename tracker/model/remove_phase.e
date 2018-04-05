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
			if attached track.get_phases.at (pid) as prev_phase then
				p_name := prev_phase.get_name
				p_cap := prev_phase.get_capacity
				p_materials := prev_phase.get_mats
			else
				p_name := ""
				p_cap := 0
				p_materials := <<>>
			end
			msg := m_a.ok
		end

feature -- Attributes

	p_id: STRING
	p_name: STRING
	p_cap: INTEGER_64
	p_materials: ARRAY[INTEGER_64]

feature

	execute
		do
			track.remove_phase(p_id)
		end

	undo
		do
			track.new_phase (p_id, p_name, p_cap, p_materials)
		end

	redo
		do
			execute
		end

end
