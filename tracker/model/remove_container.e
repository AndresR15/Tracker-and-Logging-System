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
			prev_container := tracker_access.m.get_container (cid)
			msg := "ok"
		end

feature -- Attributes

	cid: STRING

	prev_container: detachable PHASE_CONTAINER

feature

	execute
		do
			track.remove_container (cid)
		end

	undo
		do
			if attached prev_container as p_c then
				track.new_container (cid, [p_c.get_material, p_c.get_rad], p_c.get_pid)
			end

		end

	redo
		do
			execute
		end

end
