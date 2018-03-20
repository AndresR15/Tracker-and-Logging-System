--
--	grammar for an event trace parser
--
%{
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

%}

-- the symbol calculate is the root of the parse tree
%start	input

-- these are tokens that appear as part of the grammar in addition to single characters
%token<INTEGER> NUMBER 		-- a integer number
%token<REAL> 	REAL   		-- a real number 
%token<STRING>  IDENT  		-- a string identifier
%token			CHAR_LIT	-- a character literal
%token			STR_LIT 	-- a string literal
%token 			TK_SYSTEM
%token 			TK_BOOL
%token 			TK_BOOLEAN
%token			TK_CHAR
%token			TK_CHARACTER
%token			TK_INT
%token			TK_INTEGER
%token 			TK_REAL
%token    		TK_STR
%token			TK_VALUE
%token 			TK_TUPLE
%token			TK_ARRAY
%token 			TK_TRUE
%token			TK_FALSE
%token			TK_COMMA
%token 			TK_COLON      
%token 			TK_SEMI_COLON 
%token 			TK_LPAREN	  
%token 			TK_RPAREN     
%token 			TK_LSBRAC    
%token			TK_RSBRAC    
%token			TK_LABRAC
%token			TK_RABRAC
%token 			TK_LCBRAC
%token			TK_RCBRAC
%token 			TK_DQUOTE
%token			TK_MINUS
%token			TK_UPTO
%token			TK_TYPE
%token			TK_EQ
%token	EOL -- an end-of-line character

%type<ARRAY[TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]]>	evt_trace 
%type<ARRAY[ETF_EVT_ARG]> 						evt_arg_list_or_empty
%type<ARRAY[ETF_EVT_ARG]> 						evt_arg_list
%type<ETF_EVT_ARG>								evt_arg
%type<ETF_PRIMITIVE_ARG>						primitive_arg
%type<ETF_COMPOSITE_ARG>						composite_arg
%type<ARRAY[ETF_PRIMITIVE_ARG]>					primitive_arg_list
%type<ARRAY[ETF_PRIMITIVE_ARG]>					primitive_simple_arg_list 	-- for tuple expressions
%type<ETF_PRIMITIVE_ARG>						primitive_simple_arg		-- for tuple expressions
%type<STRING>									set_current_evt

%%

input : -- identify system context and call events
    evt_trace
    {
	  event_trace := $1
	}
	;

evt_trace :
	-- Empty rule, create an empty array
		{ 
		  create {ARRAY[TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]]} $$.make_empty
		}
	|	evt_trace 
		set_current_evt
		evt_arg_list_or_empty
	    {
		  $$ := $1
		  $$.force([$2, $3], $$.upper + 1)
		}
	;
	
set_current_evt:
	IDENT
	{
	  current_evt := $1
	  $$ := $1
	}
	;
	
evt_arg_list_or_empty:
	  -- Empty rule
	  {
		create $$.make_empty
	  }
	| TK_LPAREN evt_arg_list TK_RPAREN
	  {
		$$ := $2
	  }
	;
	
evt_arg_list : 
	  evt_arg 
	  { 
		create $$.make_empty	
		if attached evt_param_types[current_evt] as evt then
			current_param := evt.first
			$$.force(value_to_int_or_real ($1, current_param), $$.upper + 1)
		else
			-- 'curren_evt' does not exist: no need to convert occurrences of values to ints or reals
			$$.force($1, $$.upper + 1)
		end
	  }
	| evt_arg_list TK_COMMA evt_arg
	  { 
	    $$ := $1 
		if attached evt_param_types[current_evt] as evt then
			current_param := evt[$1.count + 1]
			$$.force(value_to_int_or_real ($3, current_param), $$.upper + 1)
		else
			-- 'curren_evt' does not exist: no need to convert occurrences of values to ints or reals
			$$.force($3, $$.upper + 1)
		end
	  }
	;
	
evt_arg : 
	  primitive_arg { $$ := $1 }
	| composite_arg { $$ := $1 }
	;

primitive_arg :
	  primitive_simple_arg { $$ := $1 }
	| TK_LSBRAC primitive_simple_arg_list TK_RSBRAC
	  {
	  	create {ETF_TUPLE_ARG} $$.make($2)
	  }
 	;
	
primitive_simple_arg :
      TK_TRUE  					
	  { 
		create {ETF_BOOL_ARG} $$.make(true) 
		$$.set_src_out (last_string_value)
	  }
    | TK_FALSE 					
	  { 
		create {ETF_BOOL_ARG} $$.make(false) 
		$$.set_src_out (last_string_value)
	  }
	| CHAR_LIT
	  {
		create {ETF_CHAR_ARG} $$.make(last_character)
		$$.set_src_out (last_string_value)
	  }
	| STR_LIT
	  { 
		create {ETF_STR_ARG}  $$.make(last_string_value) 
		$$.set_src_out (last_string_value)
	  }
	| NUMBER  					
	  { 
		create {ETF_VALUE_ARG} $$.make(last_string_value)
	  }
	| TK_MINUS NUMBER
	  {
		create {ETF_VALUE_ARG} $$.make("-" + last_string_value)
	  }
	| REAL						
	  { 
		create {ETF_VALUE_ARG} $$.make(last_string_value)
	  }
	| TK_MINUS REAL
	  {
		create {ETF_VALUE_ARG} $$.make("-" + last_string_value)
	  }
	| IDENT
	  {
		if enum_items.has_key ($1) then
			create {ETF_ENUM_INT_ARG} $$.make (enum_items[$1])
			$$.set_src_out ($1)
		else
			report_error ("Unknown identifier " + $1)
			create {ETF_ENUM_INT_ARG} $$.make (-1) -- just to make void safety work!
		end
	  }
	;
	
composite_arg :
	  TK_LABRAC TK_LABRAC primitive_arg_list TK_RABRAC TK_RABRAC
	  { 
		create {ETF_ARRAY_ARG} $$.make($3) 
	  }
	;
	
primitive_arg_list :
	  -- empty primitive arg list
	  { create $$.make_empty }
	| primitive_arg
	  {
	    $$ := <<$1>>
	  }
	| primitive_arg_list TK_COMMA primitive_arg 
	  {  
		$$ := $1
		$$.force($3, $$.upper + 1)
	  }
	;
	
primitive_simple_arg_list :
	  -- empty simple primitive arg list
	  { create $$.make_empty }
	| primitive_simple_arg
	  {
	    $$ := <<$1>>
	  }
	| primitive_simple_arg_list TK_COMMA primitive_simple_arg 
	  {  
		$$ := $1
		$$.force($3, $$.upper + 1)
	  }
	;
%%

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


