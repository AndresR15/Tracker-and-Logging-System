note
	description: "Espec Tests"
	author: "Andres Rojas and Victor Vavan"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.

		do
			add_boolean_case (agent t1)
            add_boolean_case (agent t2)
		end

feature

	t1: BOOLEAN
		local
			model_access: TRACKER_ACCESS
			model: TRACKER
		do
			comment("t1: Tests the phase removal function")
			model := model_access.m
			check attached model as m then
				m.new_tracker (m.get_max_phase_rad, m.get_max_cont_rad)
				m.new_phase ("pid2", "packing", 2, <<1>>)
				m.remove_phase ("pid2")
				Result := not m.get_phases.has ("pid2")
			end
			check Result end
		end

	t2: BOOLEAN
		local
			model_access: TRACKER_ACCESS
			model: TRACKER
			six: VALUE
			zero: VALUE
			one: INTEGER_64
		do
			comment("t2: Tests the container removal function")
			model := model_access.m
			create six.make_from_int (6)
			create zero.make_from_int (0)
			one := 1
			check attached model as m then
				m.new_tracker (six, six)
				m.new_phase ("pid1", "packing", 2, <<1>>)
				m.new_container ("cid1", [one, zero], "pid1")
				m.remove_container ("cid1")
				Result := not m.cid_exists ("cid1")
			end
			check Result end
		end

end
