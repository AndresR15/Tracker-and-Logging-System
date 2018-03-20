class ETF_EVT_TRACE_PARSER 

inherit

	YY_PARSER_SKELETON
		rename
			make as make_parser_skeleton
		redefine
			report_error
		end	
			
	ETF_EVT_SCANNER
		rename
			make as make_scanner
		end

create 
	make
		
feature {ANY}


feature {NONE} -- Implementation

	yy_build_parser_tables
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks
			-- Create value stacks.
		do
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		end

	yy_init_value_stacks
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
			yyvsp10 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			yyvs1.keep_head (0)
			yyvs2.keep_head (0)
			yyvs3.keep_head (0)
			yyvs4.keep_head (0)
			yyvs5.keep_head (0)
			yyvs6.keep_head (0)
			yyvs7.keep_head (0)
			yyvs8.keep_head (0)
			yyvs9.keep_head (0)
			yyvs10.keep_head (0)
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
				end
				yyspecial_routines1.force (yyvs1, last_detachable_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs2")
					end
					yyvsc2 := yyvsc2 + yyInitial_yyvs_size
					yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
				end
				yyspecial_routines2.force (yyvs2, last_integer_value, yyvsp2)
			when 3 then
				yyvsp3 := yyvsp3 + 1
				if yyvsp3 >= yyvsc3 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs3")
					end
					yyvsc3 := yyvsc3 + yyInitial_yyvs_size
					yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
				end
				yyspecial_routines3.force (yyvs3, last_real_value, yyvsp3)
			when 4 then
				yyvsp4 := yyvsp4 + 1
				if yyvsp4 >= yyvsc4 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs4")
					end
					yyvsc4 := yyvsc4 + yyInitial_yyvs_size
					yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
				end
				yyspecial_routines4.force (yyvs4, last_string_value, yyvsp4)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: detachable ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				debug ("GEYACC")
					std.error.put_line ("Resize yyvs1")
				end
				yyvsc1 := yyvsc1 + yyInitial_yyvs_size
				yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
			end
			yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER)
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
			when 10 then
				yyvsp10 := yyvsp10 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_run_geyacc
			-- You must run geyacc to regenerate this class.
		do
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval1: detachable ANY
			yyval5: ARRAY [TUPLE [name: STRING; args: ARRAY [ETF_EVT_ARG]]]
			yyval4: STRING
			yyval6: ARRAY [ETF_EVT_ARG]
			yyval7: ETF_EVT_ARG
			yyval8: ETF_PRIMITIVE_ARG
			yyval9: ETF_COMPOSITE_ARG
			yyval10: ARRAY [ETF_PRIMITIVE_ARG]
		do
				inspect yy_act
when 1 then
--|#line 82 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 82")
end

	  event_trace := yyvs5.item (yyvsp5)
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 2 then
--|#line 89 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 89")
end

		  create {ARRAY[TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]]} yyval5.make_empty
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp5 := yyvsp5 + 1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 3 then
--|#line 94 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 94")
end

		  yyval5 := yyvs5.item (yyvsp5)
		  yyval5.force([yyvs4.item (yyvsp4), yyvs6.item (yyvsp6)], yyval5.upper + 1)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp6 := yyvsp6 -1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 4 then
--|#line 103 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 103")
end

	  current_evt := yyvs4.item (yyvsp4)
	  yyval4 := yyvs4.item (yyvsp4)
	
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 5 then
--|#line 111 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 111")
end

		create yyval6.make_empty
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp6 := yyvsp6 + 1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 6 then
--|#line 116 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 116")
end

		yyval6 := yyvs6.item (yyvsp6)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 7 then
--|#line 122 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 122")
end

		create yyval6.make_empty	
		if attached evt_param_types[current_evt] as evt then
			current_param := evt.first
			yyval6.force(value_to_int_or_real (yyvs7.item (yyvsp7), current_param), yyval6.upper + 1)
		else
			-- 'curren_evt' does not exist: no need to convert occurrences of values to ints or reals
			yyval6.force(yyvs7.item (yyvsp7), yyval6.upper + 1)
		end
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 8 then
--|#line 134 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 134")
end

	    yyval6 := yyvs6.item (yyvsp6) 
		if attached evt_param_types[current_evt] as evt then
			current_param := evt[yyvs6.item (yyvsp6).count + 1]
			yyval6.force(value_to_int_or_real (yyvs7.item (yyvsp7), current_param), yyval6.upper + 1)
		else
			-- 'curren_evt' does not exist: no need to convert occurrences of values to ints or reals
			yyval6.force(yyvs7.item (yyvsp7), yyval6.upper + 1)
		end
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp7 := yyvsp7 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 9 then
--|#line 147 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 147")
end

yyval7 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 10 then
--|#line 149 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 149")
end

yyval7 := yyvs9.item (yyvsp9) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 11 then
--|#line 152 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 152")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 12 then
--|#line 154 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 154")
end

	  	create {ETF_TUPLE_ARG} yyval8.make(yyvs10.item (yyvsp10))
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp10 := yyvsp10 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 13 then
--|#line 160 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 160")
end

		create {ETF_BOOL_ARG} yyval8.make(true) 
		yyval8.set_src_out (last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 14 then
--|#line 166 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 166")
end

		create {ETF_BOOL_ARG} yyval8.make(false) 
		yyval8.set_src_out (last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 15 then
--|#line 171 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 171")
end

		create {ETF_CHAR_ARG} yyval8.make(last_character)
		yyval8.set_src_out (last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 16 then
--|#line 176 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 176")
end

		create {ETF_STR_ARG}  yyval8.make(last_string_value) 
		yyval8.set_src_out (last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 17 then
--|#line 181 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 181")
end

		create {ETF_VALUE_ARG} yyval8.make(last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 18 then
--|#line 185 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 185")
end

		create {ETF_VALUE_ARG} yyval8.make("-" + last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 19 then
--|#line 189 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 189")
end

		create {ETF_VALUE_ARG} yyval8.make(last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 20 then
--|#line 193 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 193")
end

		create {ETF_VALUE_ARG} yyval8.make("-" + last_string_value)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 21 then
--|#line 197 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 197")
end

		if enum_items.has_key (yyvs4.item (yyvsp4)) then
			create {ETF_ENUM_INT_ARG} yyval8.make (enum_items[yyvs4.item (yyvsp4)])
			yyval8.set_src_out (yyvs4.item (yyvsp4))
		else
			report_error ("Unknown identifier " + yyvs4.item (yyvsp4))
			create {ETF_ENUM_INT_ARG} yyval8.make (-1) -- just to make void safety work!
		end
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 22 then
--|#line 209 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 209")
end

		create {ETF_ARRAY_ARG} yyval9.make(yyvs10.item (yyvsp10)) 
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp9 := yyvsp9 + 1
	yyvsp1 := yyvsp1 -4
	yyvsp10 := yyvsp10 -1
	if yyvsp9 >= yyvsc9 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs9")
		end
		yyvsc9 := yyvsc9 + yyInitial_yyvs_size
		yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
when 23 then
--|#line 216 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 216")
end

create yyval10.make_empty 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp10 := yyvsp10 + 1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 24 then
--|#line 219 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 219")
end

	    yyval10 := <<yyvs8.item (yyvsp8)>>
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 25 then
--|#line 223 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 223")
end

		yyval10 := yyvs10.item (yyvsp10)
		yyval10.force(yyvs8.item (yyvsp8), yyval10.upper + 1)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp8 := yyvsp8 -1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 26 then
--|#line 230 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 230")
end

create yyval10.make_empty 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp10 := yyvsp10 + 1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 27 then
--|#line 233 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 233")
end

	    yyval10 := <<yyvs8.item (yyvsp8)>>
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 28 then
--|#line 237 "ETF_evt_trace_parser_def.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ETF_evt_trace_parser_def.y' at line 237")
end

		yyval10 := yyvs10.item (yyvsp10)
		yyval10.force(yyvs8.item (yyvsp8), yyval10.upper + 1)
	  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp8 := yyvsp8 -1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
				else
					debug ("GEYACC")
						std.error.put_string ("Error in parser: unknown rule id: ")
						std.error.put_integer (yy_act)
						std.error.put_new_line
					end
					abort
				end
		end

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 38 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER]
			-- Template for `yytranslate'
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   49,   39,   39,   48,   40,   40,   41,   41,   42,
			   42,   43,   43,   47,   47,   47,   47,   47,   47,   47,
			   47,   47,   44,   45,   45,   45,   46,   46,   46, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    5,    4,    4,    1,    6,    1,    1,    1,    1,
			    1,    1,    1,    4,    3,    2,    6,    7,    8,    9,
			    8,    3,    2,    1,   10,    8,    1,    1,    8,   10,
			    1,    1,    7,    1,    1,    8,    1,    8,    1,    1,
			    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    3,    4,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    2,    1,    4,    5,    0,    3,    0,    0,   26,   14,
			   13,   16,   15,   21,   19,   17,    0,    7,    9,   10,
			   11,   20,   18,   23,    0,   27,    6,    0,   24,    0,
			   12,    0,    8,    0,    0,   28,   22,   25,    0,    0,
			    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			    1,    5,   16,   17,   18,   19,   29,   24,   20,    3,
			   38, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			 -32768,   40, -32768,   19,   -3, -32768,   39,   11,    7, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   12, -32768, -32768, -32768,
			 -32768, -32768, -32768,    2,   -7, -32768, -32768,   -3, -32768,    3,
			 -32768,    7, -32768,    5,    2, -32768, -32768, -32768,   32,   20,
			 -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768,   10,   -4, -32768, -32768, -32768,    8, -32768,
			 -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			   15,   14,   13,   12,   11,   15,   14,   13,   12,   11,
			   15,   14,   13,   12,   11,   31,   25,   10,    9,   28,
			   40,   30,   10,    9,    8,   34,    7,   10,    9,    8,
			   37,    6,   39,   33,   27,   36,    6,   32,   26,   35,
			   23,    6,   22,   21,    4,    2, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    3,    4,    5,    6,    7,    3,    4,    5,    6,    7,
			    3,    4,    5,    6,    7,   22,    8,   20,   21,   23,
			    0,   28,   20,   21,   27,   22,   29,   20,   21,   27,
			   34,   34,    0,   30,   22,   30,   34,   27,   26,   31,
			   29,   34,    3,    4,   25,    5, yyDummy>>)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [detachable ANY]
			-- Stack for semantic values of type detachable ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [detachable ANY]
			-- Routines that ought to be in SPECIAL [detachable ANY]

	yyvs2: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [INTEGER]
			-- Routines that ought to be in SPECIAL [INTEGER]

	yyvs3: SPECIAL [REAL]
			-- Stack for semantic values of type REAL

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [REAL]
			-- Routines that ought to be in SPECIAL [REAL]

	yyvs4: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs5: SPECIAL [ARRAY [TUPLE [name: STRING; args: ARRAY [ETF_EVT_ARG]]]]
			-- Stack for semantic values of type ARRAY [TUPLE [name: STRING; args: ARRAY [ETF_EVT_ARG]]]

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [ARRAY [TUPLE [name: STRING; args: ARRAY [ETF_EVT_ARG]]]]
			-- Routines that ought to be in SPECIAL [ARRAY [TUPLE [name: STRING; args: ARRAY [ETF_EVT_ARG]]]]

	yyvs6: SPECIAL [ARRAY [ETF_EVT_ARG]]
			-- Stack for semantic values of type ARRAY [ETF_EVT_ARG]

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [ARRAY [ETF_EVT_ARG]]
			-- Routines that ought to be in SPECIAL [ARRAY [ETF_EVT_ARG]]

	yyvs7: SPECIAL [ETF_EVT_ARG]
			-- Stack for semantic values of type ETF_EVT_ARG

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [ETF_EVT_ARG]
			-- Routines that ought to be in SPECIAL [ETF_EVT_ARG]

	yyvs8: SPECIAL [ETF_PRIMITIVE_ARG]
			-- Stack for semantic values of type ETF_PRIMITIVE_ARG

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [ETF_PRIMITIVE_ARG]
			-- Routines that ought to be in SPECIAL [ETF_PRIMITIVE_ARG]

	yyvs9: SPECIAL [ETF_COMPOSITE_ARG]
			-- Stack for semantic values of type ETF_COMPOSITE_ARG

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [ETF_COMPOSITE_ARG]
			-- Routines that ought to be in SPECIAL [ETF_COMPOSITE_ARG]

	yyvs10: SPECIAL [ARRAY [ETF_PRIMITIVE_ARG]]
			-- Stack for semantic values of type ARRAY [ETF_PRIMITIVE_ARG]

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [ARRAY [ETF_PRIMITIVE_ARG]]
			-- Routines that ought to be in SPECIAL [ARRAY [ETF_PRIMITIVE_ARG]]

feature {NONE} -- Constants

	yyFinal: INTEGER = 40
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 39
			-- Number of tokens

	yyLast: INTEGER = 45
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 293
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 50
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature -- create

	make (
		param_types: HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]; 
		items: HASH_TABLE[INTEGER, STRING]
	)
			-- Create a event trace parser.
		do
			last_string_value := ""
			make_parser_skeleton
			make_scanner
			create event_trace.make_empty	
			last_error := ""
			evt_param_types := param_types
			enum_items := items
			current_evt := ""
			create {ETF_BOOL_PARAM} current_param
		end
		
feature -- access  

	event_trace : ARRAY[TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]]
	last_error : STRING
	evt_param_types : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
	enum_items : HASH_TABLE[INTEGER, STRING]

feature -- context
	
	current_evt : STRING
	current_param : ETF_PARAM_TYPE
	
	value_to_int_or_real (arg: ETF_EVT_ARG; param_type: ETF_PARAM_TYPE) : ETF_EVT_ARG
		do
			if attached {ETF_NAMED_PARAM_TYPE} param_type as nt then
				Result := value_to_int_or_real (arg, nt.type)
			elseif attached {ETF_PRIMITIVE_PARAM_TYPE} param_type as prim then
				Result := value_to_int_or_real_primitive (arg, prim)
			else 
				check attached {ETF_ARRAY_PARAM} param_type as comp then
					Result := value_to_int_or_real_composite (arg, comp)
				end
			end
		end
	
	value_to_int_or_real_primitive (arg: ETF_EVT_ARG; param_type: ETF_PRIMITIVE_PARAM_TYPE) : ETF_EVT_ARG
		do
			if attached {ETF_INT_PARAM} param_type then
				Result := value_to_int (arg)
			elseif attached {ETF_REAL_PARAM} param_type then
				Result := value_to_real (arg)
			elseif attached {ETF_INTERVAL_PARAM} param_type then
				Result := value_to_int (arg)
			elseif attached {ETF_TUPLE_PARAM} param_type as tup then
				Result := value_to_int_or_real_tuple (arg, tup)
			else
				Result := arg
			end
		end
	
	value_to_int_or_real_tuple (arg: ETF_EVT_ARG; param_type: ETF_TUPLE_PARAM) : ETF_EVT_ARG
		local
			args: ARRAY[ETF_EVT_ARG]
			i: INTEGER
		do
			if attached {ETF_TUPLE_ARG} arg as tup and then
				tup.value.count = param_type.base_types.count
			then
				create args.make_empty
				from
					i := param_type.base_types.lower
				until
					i > param_type.base_types.upper
				loop
					args.force(
						value_to_int_or_real (tup.value[i], param_type.base_types[i].type), 
						args.upper + 1)
					i := i + 1
				end
				create {ETF_TUPLE_ARG} Result.make (args)
			else
				-- inconsistent 'arg' against 'param_type', no conversion needed 
				Result := arg
			end
		end
	
	value_to_int_or_real_composite (arg: ETF_EVT_ARG; param_type: ETF_ARRAY_PARAM) : ETF_EVT_ARG
		local
			args: ARRAY[ETF_EVT_ARG]
			i: INTEGER
		do
			if attached {ETF_ARRAY_ARG} arg as array_arg then
				create args.make_empty
				from
					i := array_arg.value.lower
				until
					i > array_arg.value.upper
				loop
					args.force(
						value_to_int_or_real_primitive (array_arg.value[i], param_type.base_type), 
						args.upper + 1)
					i := i + 1
				end
				create {ETF_ARRAY_ARG} Result.make (args)
			else
				Result := arg
			end
		end
	
	value_to_int (arg: ETF_EVT_ARG) : ETF_EVT_ARG
		do
			if attached {ETF_VALUE_ARG} arg as val_arg then
				if val_arg.value.precise_out.is_integer_64 then
					create {ETF_INT_ARG} Result.make(val_arg.value.precise_out.to_integer_64)
				else
					report_error ("Invalid number for 64-bit integer " + val_arg.value.precise_out)
					Result := arg
				end 
			else
				Result := arg
			end
		end
		
	value_to_real (arg: ETF_EVT_ARG) : ETF_EVT_ARG
		do
			if attached {ETF_VALUE_ARG} arg as val_arg then
				if val_arg.value.precise_out.is_real_64 then
					create {ETF_REAL_ARG} Result.make(val_arg.value.precise_out.to_real_64)
				else
					report_error ("Invalid number for double-precision, real value " + val_arg.value.precise_out)
					Result := arg
				end 
			else
				Result := arg
			end
		end

feature -- parsing

	report_error(a_message: STRING)
		do
			last_error := a_message + " (Line " + line.out + ", " + "Column " + column.out + ")" 
		end

	parse_string(str :STRING)
			-- parse the text of this given string
		local
			buf : YY_BUFFER
		do
			create buf.make(str)
			
			reset
			set_input_buffer(buf)
			parse
		end

	parse_file(filename:STRING)
			-- parse the text of the given input file
		local
			a_file: KL_TEXT_INPUT_FILE
		do
			create a_file.make (filename)
			a_file.open_read
			
			if a_file.is_open_read then
				reset
				set_input_buffer (new_file_buffer (a_file))
				parse
				a_file.close
			else
				std.error.put_string ("event declaration parser: cannot read %'"+filename+"%'%N")
			end
		end
	
end


