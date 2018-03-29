note
	description: "Summary description for {NEW_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CONTAINER

inherit
	COMMAND

Create
		make

feature -- Initialization

	make (init_cid: STRING; cont_spec: TUPLE [m: INTEGER_64; rad: VALUE]; init_pid: STRING)
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			pid := init_pid
			cid := init_cid
			material := cont_spec.m
			rad := cont_spec.rad
			state := track.get_state
			msg := "ok"
		end

feature -- Attributes

	cid, pid: STRING

	material: INTEGER_64

	rad: VALUE

feature

	execute
		do
			track.new_container(cid, [material, rad], pid)
		end

	undo
		do
			track.remove_container (cid)
		end

	redo
		do
			execute
		end

end
