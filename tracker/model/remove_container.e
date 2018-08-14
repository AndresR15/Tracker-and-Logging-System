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
			if attached tracker_access.m.get_container (cid) as prev_cont then
				material := prev_cont.get_material
				rad := prev_cont.get_rad
				current_pid := prev_cont.get_pid
			else
				material := 0
				create rad.make_from_int (0)
				current_pid := ""
			end
			msg := m_a.ok
		end

feature -- Attributes

	cid: STRING
	material: INTEGER_64
	rad: VALUE
	current_pid: STRING

feature

	execute
		do
			track.remove_container (cid)
		end

	undo
		do
			track.new_container (cid, [material, rad], current_pid)
		end

	redo
		do
			execute
		end

end
