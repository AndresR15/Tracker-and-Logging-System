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

	m_a: MESSAGES_ACCESS

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
		local
			tracker_access: TRACKER_ACCESS
		do
			if attached track as t then
				t.set_cursor_state (state)
			else
				track := tracker_access.m
				track.set_cursor_state (0)
			end
		end

end
