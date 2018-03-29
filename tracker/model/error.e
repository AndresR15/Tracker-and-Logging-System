note
	description: "Summary description for {ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR

inherit

	COMMAND

create
	make

feature -- Initialization

	make (error: STRING)
		local
			track_access: TRACKER_ACCESS
		do
			track := track_access.m
			msg := error
			state := track.get_state
		end

feature

	execute
		do
			track.set_error (msg)
			track.set_cursor_state (state)
		end

	undo
		do
			track.get_history.get_record.back
			track.set_error (track.get_history.get_record.item.msg)
		end

	redo
		do
			execute
		end

end
