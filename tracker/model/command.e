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

end
