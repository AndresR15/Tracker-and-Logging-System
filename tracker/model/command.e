note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND

feature -- Attributes

	track: TRACKER

	msg: STRING

	state: INTEGER

feature

	execute
		deferred
		end

	undo
		deferred
		end

	redo
		deferred
		end

	set_state
		do
			track.set_cursor_state (state)
		end

end
