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

		end

	undo
		do
	
		end

	redo
		do

		end

end
