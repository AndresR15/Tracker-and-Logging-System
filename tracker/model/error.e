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
		end

	undo
		do
			-- empty
		end

	redo
		do
			execute
		end

end
