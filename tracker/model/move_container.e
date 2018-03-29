note
	description: "Summary description for {MOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_CONTAINER

inherit

	COMMAND

create
	make

feature -- Initialization

	make (init_cid: STRING; init_pid1: STRING; init_pid2: STRING)
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			cid := init_cid
			pid1 := init_pid1
			pid2 := init_pid2
			state := track.get_state
			msg := "ok"
		end

feature -- Attributes

	cid, pid1, pid2: STRING

feature

	execute
		do
			track.move_container (cid, pid1, pid2)
		end

	undo
		do
			track.move_container (cid, pid2, pid1)
		end

	redo
		do
			execute
		end

end
