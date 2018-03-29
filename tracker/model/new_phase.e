note
	description: "Summary description for {NEW_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_PHASE

inherit
	COMMAND

create
	make

feature -- Initialization

	make (pid: STRING; pname: STRING; cap: INTEGER_64; mats: ARRAY [INTEGER_64])
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			p_id := pid
			p_name := pname
			capacity := cap
			expected_mats := mats
			state := track.get_state
			msg := "ok"
		end

feature -- Attributes

	p_id, p_name: STRING

	capacity: INTEGER_64

	expected_mats: ARRAY [INTEGER_64]

feature

	execute
		do
			track.new_phase(p_id, p_name, capacity, expected_mats)
		end

	undo
		do
			track.remove_phase(p_id)
		end

	redo
		do
			execute
		end

end
