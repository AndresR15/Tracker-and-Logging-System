note
	description: "Summary description for {NEW_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CONTAINER

inherit
	COMMAND


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
			msg := "ok"
		end

feature -- Attributes

	cid, pid: STRING

	material: INTEGER_64

	rad: VALUE

feature

	execute
		do
			track.new_container(cid, TUPLE[material, rad], pid)
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
