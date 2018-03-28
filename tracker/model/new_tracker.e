note
	description: "Summary description for {NEW_TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_TRACKER

inherit
	COMMAND

Create
	make

feature	{NONE}
	make
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			state := track.get_state
			msg := "ok"
		end

feature

	execute
		do
			-- nothing
		end

	undo
		do
			-- nothing
		end

	redo
		do
			-- nothing
		end

end
