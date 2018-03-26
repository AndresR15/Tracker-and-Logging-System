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
			msg := "ok"
		end

feature -- Attributes

	p_id: STRING

feature

	execute
		do
			track.remove_phase(p_id)
		end

	undo
		do
			track.get_history.get_record.back
			execute
		end

	redo
		do
			execute
		end

end
