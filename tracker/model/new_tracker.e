note
	description: "Summary description for {NEW_TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_TRACKER

inherit
	COMMAND

Create
	make

feature	{NONE}
	make(max_phase_radiation: VALUE; max_container_radiation: VALUE)
		local
			tracker_access: TRACKER_ACCESS
		do
			track := tracker_access.m
			state := track.get_state
			msg := "ok"
			max_cont_rad := max_container_radiation
			max_phase_rad := max_phase_radiation
		end

feature -- Attributes

	max_cont_rad, max_phase_rad: VALUE

feature

	execute
		do
			track.new_tracker(max_phase_rad, max_cont_rad)
		end

	undo
		do
			-- nothing
		end

	redo
		do
			execute
		end

end
