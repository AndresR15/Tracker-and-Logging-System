class
 	 ETF_TYPE_CONSTRAINTS

feature -- type queries 

	is_material(etf_v: INTEGER_64): BOOLEAN 
		require
			comment("etf_v: MATERIAL = {glass, metal, plastic, liquid}")
		do
			 Result := 
				(( etf_v ~ glass ) or else ( etf_v ~ metal ) or else ( etf_v ~ plastic ) or else ( etf_v ~ liquid ))
		ensure
			 Result = 
				(( etf_v ~ glass ) or else ( etf_v ~ metal ) or else ( etf_v ~ plastic ) or else ( etf_v ~ liquid ))
		end

	is_container(etf_v: TUPLE[material: INTEGER_64; radioactivity: VALUE]): BOOLEAN 
		require
			comment("etf_v: CONTAINER = TUPLE[material: MATERIAL = {glass, metal, plastic, liquid}; radioactivity: VALUE]")
		do
			 Result := 
				is_material(etf_v.material)
		ensure
			 Result = 
				is_material(etf_v.material)
		end

feature -- constants for enumerated items 
	glass: INTEGER =1
	metal: INTEGER =2
	plastic: INTEGER =3
	liquid: INTEGER =4

feature -- list of enumeratd constants
	enum_items : HASH_TABLE[INTEGER, STRING]
		do
			create Result.make (10)
			Result.extend(1, "glass")
			Result.extend(2, "metal")
			Result.extend(3, "plastic")
			Result.extend(4, "liquid")
		end

	enum_items_inverse : HASH_TABLE[STRING, INTEGER_64]
		do
			create Result.make (10)
			Result.extend("glass", 1)
			Result.extend("metal", 2)
			Result.extend("plastic", 3)
			Result.extend("liquid", 4)
		end
feature -- query on declarations of event parameters
	evt_param_types_table : HASH_TABLE[HASH_TABLE[ETF_PARAM_TYPE, STRING], STRING]
		local
			new_tracker_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			new_phase_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			remove_phase_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			new_container_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			remove_container_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			move_container_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			undo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			redo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
		do
			create Result.make (10)
			Result.compare_objects
			create new_tracker_param_types.make (10)
			new_tracker_param_types.compare_objects
			new_tracker_param_types.extend (create {ETF_VALUE_PARAM}, "max_phase_radiation")
			new_tracker_param_types.extend (create {ETF_VALUE_PARAM}, "max_container_radiation")
			Result.extend (new_tracker_param_types, "new_tracker")
			create new_phase_param_types.make (10)
			new_phase_param_types.compare_objects
			new_phase_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}), "pid")
			new_phase_param_types.extend (create {ETF_STR_PARAM}, "phase_name")
			new_phase_param_types.extend (create {ETF_INT_PARAM}, "capacity")
			new_phase_param_types.extend (create {ETF_ARRAY_PARAM}.make (create {ETF_NAMED_PARAM_TYPE}.make("MATERIAL", create {ETF_ENUM_PARAM}.make(<<"glass", "metal", "plastic", "liquid">>))), "expected_materials")
			Result.extend (new_phase_param_types, "new_phase")
			create remove_phase_param_types.make (10)
			remove_phase_param_types.compare_objects
			remove_phase_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}), "pid")
			Result.extend (remove_phase_param_types, "remove_phase")
			create new_container_param_types.make (10)
			new_container_param_types.compare_objects
			new_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CID", create {ETF_STR_PARAM}), "cid")
			new_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CONTAINER", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("material", create {ETF_NAMED_PARAM_TYPE}.make("MATERIAL", create {ETF_ENUM_PARAM}.make(<<"glass", "metal", "plastic", "liquid">>))), create {ETF_PARAM_DECL}.make("radioactivity", create {ETF_VALUE_PARAM})>>)), "c")
			new_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}), "pid")
			Result.extend (new_container_param_types, "new_container")
			create remove_container_param_types.make (10)
			remove_container_param_types.compare_objects
			remove_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CID", create {ETF_STR_PARAM}), "cid")
			Result.extend (remove_container_param_types, "remove_container")
			create move_container_param_types.make (10)
			move_container_param_types.compare_objects
			move_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CID", create {ETF_STR_PARAM}), "cid")
			move_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}), "pid1")
			move_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}), "pid2")
			Result.extend (move_container_param_types, "move_container")
			create undo_param_types.make (10)
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make (10)
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
		end
feature -- query on declarations of event parameters
	evt_param_types_list : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
		local
			new_tracker_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			new_phase_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			remove_phase_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			new_container_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			remove_container_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			move_container_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			undo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			redo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
		do
			create Result.make (10)
			Result.compare_objects
			create new_tracker_param_types.make
			new_tracker_param_types.compare_objects
			new_tracker_param_types.extend (create {ETF_VALUE_PARAM})
			new_tracker_param_types.extend (create {ETF_VALUE_PARAM})
			Result.extend (new_tracker_param_types, "new_tracker")
			create new_phase_param_types.make
			new_phase_param_types.compare_objects
			new_phase_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}))
			new_phase_param_types.extend (create {ETF_STR_PARAM})
			new_phase_param_types.extend (create {ETF_INT_PARAM})
			new_phase_param_types.extend (create {ETF_ARRAY_PARAM}.make (create {ETF_NAMED_PARAM_TYPE}.make("MATERIAL", create {ETF_ENUM_PARAM}.make(<<"glass", "metal", "plastic", "liquid">>))))
			Result.extend (new_phase_param_types, "new_phase")
			create remove_phase_param_types.make
			remove_phase_param_types.compare_objects
			remove_phase_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}))
			Result.extend (remove_phase_param_types, "remove_phase")
			create new_container_param_types.make
			new_container_param_types.compare_objects
			new_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CID", create {ETF_STR_PARAM}))
			new_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CONTAINER", create {ETF_TUPLE_PARAM}.make(<<create {ETF_PARAM_DECL}.make("material", create {ETF_NAMED_PARAM_TYPE}.make("MATERIAL", create {ETF_ENUM_PARAM}.make(<<"glass", "metal", "plastic", "liquid">>))), create {ETF_PARAM_DECL}.make("radioactivity", create {ETF_VALUE_PARAM})>>)))
			new_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}))
			Result.extend (new_container_param_types, "new_container")
			create remove_container_param_types.make
			remove_container_param_types.compare_objects
			remove_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CID", create {ETF_STR_PARAM}))
			Result.extend (remove_container_param_types, "remove_container")
			create move_container_param_types.make
			move_container_param_types.compare_objects
			move_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("CID", create {ETF_STR_PARAM}))
			move_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}))
			move_container_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("PID", create {ETF_STR_PARAM}))
			Result.extend (move_container_param_types, "move_container")
			create undo_param_types.make
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
		end
feature -- comments for contracts
	comment(etf_s: STRING): BOOLEAN
		do
			Result := TRUE
		end
end