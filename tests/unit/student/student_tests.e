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
				m.new_phase ("pid1", "packing", 2, <<1>>)
				m.remove_phase ("pid1")
				Result := m.get_phases.is_empty
			end
			check Result end
		end

	t2: BOOLEAN
		local
			model_access: TRACKER_ACCESS
			model: TRACKER
			six: VALUE
			one: INTEGER_64
		do
			comment("t2: Tests the container removal function")
			model := model_access.m
			create six.make_from_int (6)
			one := 1
			check attached model as m then
				m.new_tracker (m.get_max_phase_rad, m.get_max_cont_rad)
				m.new_phase ("pid1", "packing", 2, <<1>>)
				m.new_container ("cid1", [one, six], "pid1")
				m.remove_container ("cid1")
				Result := not m.cid_exists ("cid1")
			end
			check Result end
		end

end
