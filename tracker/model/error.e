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
		end

feature

	execute
		do
			track.set_error (msg)
		end

	undo
		do
			track.get_history.get_record.back
			track.set_error (track.get_history.get_record.item.msg)
			track.get_history.get_record.forth
		end

	redo
		do
			execute
		end

end
