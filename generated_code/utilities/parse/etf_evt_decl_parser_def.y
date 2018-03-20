--
--	grammar for an event declaration parser
--
%{
class ETF_EVT_DECL_PARSER 

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
%start	declarations

-- these are tokens that appear as part of the grammar in addition to single characters
%token<STRING> 	NUMBER		-- a integer number
%token<REAL> 	REAL      	-- a real number 
%token<STRING>  IDENT  		-- a string identifier
%token			CHAR_LIT 	-- a character literal
%token	        STR_LIT 	-- a string literal
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
%token			TK_TUPLE
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

%type<HASH_TABLE[ARRAY[ETF_PARAM_DECL], STRING]>	evt_decl_list 
%type<HASH_TABLE[ETF_NAMED_PARAM_TYPE, STRING]>		type_decl_list
%type<ARRAY[ETF_PARAM_DECL]> 						evt_param_list
%type<ETF_PARAM_DECL>								evt_param_decl
%type<ETF_PARAM_TYPE>								evt_param_type
%type<ARRAY[STRING]>								enum_item_list
%type<ETF_PRIMITIVE_PARAM_TYPE>						primitive_param_type
%type<ETF_COMPOSITE_PARAM_TYPE>						composite_param_type
%type<ARRAY[ETF_PARAM_DECL]> 						prim_simple_param_list 		-- for tuple declarations
%type<ETF_PARAM_DECL>								prim_simple_param_decl 		-- for tuple declarations
%type<ETF_PRIMITIVE_PARAM_TYPE>						primitive_simple_param_type -- for tuple declarations


%%

declarations : -- declarations of system name and events
    TK_SYSTEM IDENT type_decl_list evt_decl_list
    {
	  system_name := $2
	  event_declarations := $4
	}
	;
		
type_decl_list : 
	-- Empty type declarations, create an empty hash table
		{
		  create {HASH_TABLE[ETF_NAMED_PARAM_TYPE, STRING]} $$.make(10)
		  $$.compare_objects
	   	}
	|	type_decl_list TK_TYPE IDENT TK_EQ evt_param_type
		{
		  -- check that type names do not conflict with Eiffel reserved words
		  check_eiffel_keywords ($3, "type name")
		
		  -- check that type names are unique
		  if $1.has_key($3) then
			add_type_error("Named type '" + $3 + "' is declared multiple times")
		  end
		  
		  $$ := $1
		  $$.extend (create {ETF_NAMED_PARAM_TYPE}.make ($3, $5), $3)
		  named_types := $$
		}
		;
	
evt_decl_list :
	-- Empty rule, create an empty hash table
		{ 
		  create {HASH_TABLE[ARRAY[ETF_PARAM_DECL], STRING]} $$.make(10) 
		  $$.compare_objects
		}
	|	evt_decl_list IDENT TK_LPAREN evt_param_list TK_RPAREN
	    {
	      -- check that event names do not conflict with Eiffel reserved words
		  check_eiffel_keywords ($2, "event name")
		
		  -- check that event parameter names do not conflict with Eiffel reserved words
		  across $4 as param
		  loop
		    across eiffel_keywords as keyword
		    loop
              if keyword.item.is_case_insensitive_equal(param.item.name) then
			    add_type_error(
					"parameter name '" + param.item.name + "' of event '" + 
						$2 + "' is an Eiffel reserved word")
		      end
		    end
		  end
		
		  -- check that event names are unique
		  if $1.has_key($2) then
			add_type_error("event '" + $2 + "'" + " is declared multiple times")
	      end
		
		  -- check that parameter names for each event are unqiue
		  from  
		    i := $4.lower
			duplicates_found := FALSE
		  until 
		    i > $4.upper
		  loop
		    from
		      j := $4.lower
		    until
		      j > $4.upper OR ELSE duplicates_found 
			loop
			  if NOT (i = j) AND THEN $4[i].name ~ $4[j].name then
			    add_type_error(
					"parameter '" + $4[i].name + "' in event '" + $2 + "' is declared multiple times")
				duplicates_found := TRUE
			  end
			  j := j + 1
			end
		    i := i + 1
		  end
		
		  $$ := $1
		  $$.extend($4, $2)
		}
		|	evt_decl_list IDENT
		    {
		 	  -- check that event names are unique
		      if $1.has_key($2) then
				add_type_error ("event '" + $2 + "'" + " is declared multiple times")
			  end

			  $$ := $1
			  $$.extend(<<>>, $2)
			}
	;
	
evt_param_list : 
      evt_param_decl
      {
  	    create $$.make_empty	
        $$.force($1, $$.upper + 1)
      }
    | evt_param_list TK_SEMI_COLON evt_param_decl
	  {
	    $$ := $1
	    $$.force($3, $$.upper + 1)
	  }
	;
	
evt_param_decl :
      IDENT TK_COLON evt_param_type 
      {	
		if attached {ETF_TUPLE_PARAM} $3 as tup then
		  check_tuple_member_name_clash ($1, tup)
		end
		
		if attached {ETF_NAMED_PARAM_TYPE} $3 as nt and then 
		     attached {ETF_TUPLE_PARAM} nt.type as tup 
		then
		  check_tuple_member_name_clash ($1, tup)
		end
		
        create $$.make($1, $3)
      }
	;
	
evt_param_type :
	  primitive_param_type { $$ := $1 }
	| composite_param_type { $$ := $1 }
	| IDENT                
	  { 
	    -- check that type names are unique 
		if NOT named_types.has_key($1) then
			add_type_error("Named type '" + $1 + "' is not declared")
			-- just to achieve void safety
			$$ := create {ETF_INT_PARAM}
		else
			if attached {ETF_PARAM_TYPE} named_types[$1] as param_type then
			    -- we don't use param_type.type as we will later use param_type.name for better error reporting 
				$$ := param_type
			else
				-- not possible, just to achieve void safety
				$$ := create {ETF_INT_PARAM}
			end
		end
	  }
	;

primitive_param_type :
	  primitive_simple_param_type 							{ $$ := $1 }
	| TK_TUPLE 												{ create {ETF_TUPLE_PARAM} $$.make (<<>>)}
	| TK_TUPLE TK_LSBRAC prim_simple_param_list TK_RSBRAC	{ create {ETF_TUPLE_PARAM} $$.make ($3) 
															  check_tuple_member_name_unique ($$)
															}
	;

primitive_simple_param_type :
   	  TK_INT  										{ create {ETF_INT_PARAM}      $$                         }
   	| TK_INTEGER  									{ create {ETF_INT_PARAM}      $$                         }
	| NUMBER TK_UPTO NUMBER		
	{ 
		if $1.is_integer_64 and then $3.is_integer_64 then
			create {ETF_INTERVAL_PARAM} $$.make ($1.to_integer_64, $3.to_integer_64)
			check_interval_spec ($$)
		else
		 	if not $1.is_integer_64 then
				add_type_error ("Invalid number for 64-bit integer " + $1)
			else
				add_type_error ("Invalid number for 64-bit integer " + $3)
			end
			create {ETF_INTERVAL_PARAM} $$.make (-1, -1) -- just to make void safety work!
		end
	}
	| TK_MINUS NUMBER TK_UPTO NUMBER	    
	{ 
		if ("-" + $2).is_integer_64 and then $4.is_integer_64 then
			create {ETF_INTERVAL_PARAM} $$.make (("-" + $2).to_integer_64, $4.to_integer_64)
			check_interval_spec ($$)
		else
		 	if not ("-" + $2).is_integer_64 then
				add_type_error ("Invalid number for 64-bit integer " + ("-" + $2))
			else
				add_type_error ("Invalid number for 64-bit integer " + $4)
			end
			create {ETF_INTERVAL_PARAM} $$.make (-1, -1) -- just to make void safety work!
		end
	}
	| NUMBER TK_UPTO TK_MINUS NUMBER		
	{ 
		if $1.is_integer_64 and then ("-" + $4).is_integer_64 then
			create {ETF_INTERVAL_PARAM} $$.make ($1.to_integer_64, ("-" + $4).to_integer_64)
			check_interval_spec ($$)
		else
		 	if not $1.is_integer_64 then
				add_type_error ("Invalid number for 64-bit integer " + $1)
			else
				add_type_error ("Invalid number for 64-bit integer " + ("-" + $4))
			end
			create {ETF_INTERVAL_PARAM} $$.make (-1, -1) -- just to make void safety work!
		end
	}
	| TK_MINUS NUMBER TK_UPTO TK_MINUS NUMBER       
	{ 
		if ("-" + $2).is_integer_64 and then ("-" + $5).is_integer_64 then
			create {ETF_INTERVAL_PARAM} $$.make (("-" + $2).to_integer_64, ("-" + $5).to_integer_64)
			check_interval_spec ($$)
		else
		 	if not ("-" + $2).is_integer_64 then
				add_type_error ("Invalid number for 64-bit integer " + ("-" + $2))
			else
				add_type_error ("Invalid number for 64-bit integer " + ("-" + $5))
			end
			create {ETF_INTERVAL_PARAM} $$.make (-1, -1) -- just to make void safety work!
		end
	}
    | TK_REAL 										{ create {ETF_REAL_PARAM}     $$                         }
	| TK_VALUE										{ create {ETF_VALUE_PARAM}    $$                  		 }
	| TK_BOOL 										{ create {ETF_BOOL_PARAM}     $$                         }
	| TK_BOOLEAN									{ create {ETF_BOOL_PARAM}     $$                         }
	| TK_CHAR 										{ create {ETF_CHAR_PARAM}     $$                         }
	| TK_CHARACTER 									{ create {ETF_CHAR_PARAM}     $$                         }
	| TK_STR  										{ create {ETF_STR_PARAM}      $$                         }
	| TK_LCBRAC enum_item_list TK_RCBRAC			{ create {ETF_ENUM_PARAM}     $$.make ($2) }		
	| IDENT                
	  { 
	    -- check that type names are unique 
		if NOT named_types.has_key($1) then
			add_type_error("Named type '" + $1 + "' is not declared")
			-- just to achieve void safety
			$$ := create {ETF_INT_PARAM}
		else
		    if attached {ETF_NAMED_PARAM_TYPE} named_types[$1] as nt then
		      if attached {ETF_PRIMITIVE_PARAM_TYPE} nt.type then
				-- preserve the NAMED_TYPE structure 
		        $$ := nt
			  else
			    -- the named type does not refer to a simple type
			    add_type_error("Named type '" + nt.out + 
			      "' should not be used when a simple type is expected")
			    -- just to achieve void safety
			    $$ := create {ETF_INT_PARAM}
			  end
			else
			  -- just to achieve void safety
			  $$ := create {ETF_INT_PARAM}
			end
		end
	  }
	;
	
composite_param_type :
	  TK_ARRAY TK_LSBRAC primitive_param_type TK_RSBRAC
	  { create {ETF_ARRAY_PARAM} $$.make($3) }
	;
	
-- for tuple declarations
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	

prim_simple_param_list : 
      prim_simple_param_decl
      {
  	    create $$.make_empty	
        $$.force($1, $$.upper + 1)
      }
    | prim_simple_param_list TK_SEMI_COLON prim_simple_param_decl
	  {
	    $$ := $1
	    $$.force($3, $$.upper + 1)
	  }
	;

prim_simple_param_decl :
      IDENT TK_COLON primitive_simple_param_type 
      {
        create $$.make($1, $3)
      }
	;
	
enum_item_list : 
      IDENT
      {
		check_eiffel_keywords ($1, "Enumerated item")
  	    create $$.make_empty	
        $$.force($1, $$.upper + 1)
  		if NOT enum_items.has_key ($1) then
			enum_item_count := enum_item_count + 1
			enum_items.extend (enum_item_count, $1)
			enum_items_inverse.extend ($1, enum_item_count)
		end
      }
    | enum_item_list TK_COMMA IDENT
	  {
		check_eiffel_keywords ($3, "Enumerated item")
		
		if $1.has ($3) then
			add_type_error ("Item " + $3 + " is declared multiple times in the same enumerated type")
		end
		
	    $$ := $1
	    $$.force($3, $$.upper + 1)
	    if NOT enum_items.has_key ($3) then
			enum_item_count := enum_item_count + 1
			enum_items.extend (enum_item_count, $3)
			enum_items_inverse.extend ($3, enum_item_count)
		end
	  }
	;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

feature -- create

	make
			-- Create a new calculator
		do
			last_string_value := ""
			make_parser_skeleton
			make_scanner
			create event_declarations.make(10)
			create named_types.make(10)
			system_name := ""
			last_syntax_error := ""
			create type_errors.make
			create enum_items.make(10)
			create enum_items_inverse.make(10)
			enum_items.compare_objects
			enum_items_inverse.compare_objects
		end
		
feature {NONE} -- loop counters for validity checks
	i, j : INTEGER
	duplicates_found: BOOLEAN
	
feature {NONE} -- counter for enumerated type items
	enum_item_count : INTEGER
		
feature -- access  
    system_name : STRING
	event_declarations : HASH_TABLE[ARRAY[ETF_PARAM_DECL], STRING]
	last_syntax_error: STRING
	type_errors : LINKED_LIST[STRING]
	named_types : HASH_TABLE[ETF_NAMED_PARAM_TYPE, STRING]
	enum_items  : HASH_TABLE[INTEGER, STRING]
	enum_items_inverse: HASH_TABLE[STRING, INTEGER]
	eiffel_keywords : ARRAY[STRING]
		do
		Result :=
		<<"agent","alias","all","and","as","assign","attribute","check","class","convert","create",
		  "Current","debug","deferred","do","else","elseif","end","ensure","expanded","export","external",
		  "False","feature","from","frozen","if","implies","inherit","inspect","invariant","like","local",
		  "loop","not","note","obsolete","old","once","only","or","Precursor","redefine","rename","require",
		  "rescue","Result","retry","select","separate","then","True","TUPLE","undefine","until","variant",
		  "Void","when","xor","attached","detachable","across">>
		end

feature -- checks
 	check_interval_spec (primitive_param_type: ETF_PRIMITIVE_PARAM_TYPE)
		do
		  if attached {ETF_INTERVAL_PARAM} primitive_param_type as interval then
			if NOT (interval.lower <= interval.upper) then
			    add_type_error( 
			      "Invalid interval specification: " + 
			        interval.lower.out + " > " + interval.upper.out)
			end
		  end
		end
	
	check_tuple_member_name_clash (param_name: STRING; tup: ETF_TUPLE_PARAM)
		do
			if across tup.base_types as decl some decl.item.name ~ param_name end then 
			    add_type_error(
				  "Event parameter name " + param_name + 
				    " clashes with that of one of the tuple fields " + tup.out)
			end
		end
	
	check_tuple_member_name_unique (prim_param_type: ETF_PRIMITIVE_PARAM_TYPE)
		do
		  if attached {ETF_TUPLE_PARAM} prim_param_type as tup then
			from  
			    i := tup.base_types.lower
				duplicates_found := FALSE
			  until 
			    i > tup.base_types.upper OR ELSE duplicates_found
			  loop
			    from
			      j := tup.base_types.lower
			    until
			      j > tup.base_types.upper
				loop
				  if NOT (i = j) AND THEN tup.base_types[i].name ~ tup.base_types[j].name then
				    add_type_error(
						"tuple field '" + tup.base_types[i].name + 
							"' is declared multiple times")
					duplicates_found := TRUE
				  end
				  j := j + 1
				end
			    i := i + 1
			  end
		  end
		end
		
	check_eiffel_keywords (s: STRING; context: STRING)
		do
			across eiffel_keywords as keyword
			loop
				if keyword.item.is_case_insensitive_equal(s) then
					add_type_error (context + " '" + s + "' is an Eiffel reserved word")
				end
			end
		end
	
feature -- parsing

    add_type_error (err_msg: STRING)
		do
		  type_errors.extend ("Error (Line " + line.out + "):" + err_msg)
		end

	report_error(a_message: STRING)
		do
			last_syntax_error := text + " (Line " + line.out + ", " + "Column " + column.out + ")" 
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


