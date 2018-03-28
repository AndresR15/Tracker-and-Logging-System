note
	description: "Summary description for {REMOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_CONTAINER

inherit
	COMMAND

create
	make

feature -- Initialization

	make (init_cid: STRING)
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			cid := init_cid
			state := track.get_state
			msg := "ok"
		end

feature -- Attributes

	cid: STRING


feature

	execute
		do
			track.remove_container(cid)
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
