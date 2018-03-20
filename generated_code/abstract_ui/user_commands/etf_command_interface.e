note
	description: "Summary description for {ETF_COMMAND_INTERFACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_COMMAND_INTERFACE
	
inherit
	ETF_TYPE_CONSTRAINTS
		redefine 
			out 
		end
	
	DEBUG_OUTPUT
		undefine
			out
		redefine
			debug_output
		end

feature {NONE}
	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			create etf_cmd_message.make_empty
			etf_cmd_name := an_etf_cmd_name
			etf_cmd_container := an_etf_cmd_container
			out := ""
		end

feature -- attributes

	etf_cmd_message: STRING

	etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		--allows a command to be observable
		-- etf_cmd_container.on_change.notify ([Current])

	etf_cmd_routine: PROCEDURE

	etf_cmd_name: STRING

	out : STRING

	etf_cmd_error: BOOLEAN

	debug_output: STRING
		do
			Result := out
		end

feature {NONE} -- queries

	etf_event_argument_out(evt: STRING; param: STRING; etf_v: ANY): STRING
		do
			create Result.make_empty
			if
				attached {HASH_TABLE[ETF_PARAM_TYPE, STRING]} evt_param_types_table[evt] as param_types
			   	and then
			   	attached {ETF_PARAM_TYPE} param_types [param] as param_type
			then
				Result := etf_arg_out (param_type, etf_v)
			else
				check FALSE end
			end
		end

	etf_arg_out (etf_t: ETF_PARAM_TYPE; etf_v: ANY): STRING
		local
			param_type : ETF_PARAM_TYPE
		do
			create Result.make_empty
			param_type := retrieve_named_type_if_necessary (etf_t)
			--------------------------------------------------
			if
				attached {ETF_STR_PARAM} param_type
			then
				Result.append ("%"" + etf_v.out + "%"")
			--------------------------------------------------
			elseif
				attached {ETF_CHAR_PARAM} param_type
			then
				Result.append ("'" + etf_v.out + "'")
			--------------------------------------------------
			elseif
				attached {ETF_VALUE_PARAM} param_type
				and then 
				attached {VALUE} etf_v as value
			then
				Result.append (value.precise_out)
			--------------------------------------------------
			elseif
				attached {ETF_ARRAY_PARAM} param_type as array_param
				and then
				attached {ARRAY[ANY]} etf_v as array_arg
			then
				Result.append (etf_array_arg_out (array_param, array_arg))
			--------------------------------------------------
			elseif
				attached {ETF_TUPLE_PARAM} param_type as tuple_param
				and then
				attached {TUPLE} etf_v as tuple_arg
			then
				Result.append (etf_tuple_arg_out (tuple_param, tuple_arg))
			--------------------------------------------------
			elseif
				attached {ETF_ENUM_PARAM} param_type as enum_param
				and then
				attached {INTEGER_64} etf_v as etf_local_i
				and then
				attached {STRING} enum_items_inverse [etf_local_i] as item_name
			then
				Result.append (item_name)
			--------------------------------------------------
			else
				Result.append (etf_v.out)
			end
		end

	etf_array_arg_out (param: ETF_ARRAY_PARAM; arg: ARRAY[ANY]): STRING
		local
			etf_local_i : INTEGER
		do
			from
				create Result.make_empty
				Result.append ("<<")
				etf_local_i := arg.lower
			until
				etf_local_i > arg.upper
			loop
				Result.append (etf_arg_out (param.base_type, arg[etf_local_i]))

				if etf_local_i < arg.upper then
					Result.append (", ")
				end
				etf_local_i := etf_local_i + 1
			end
			Result.append (">>")
		end

	etf_tuple_arg_out (param: ETF_TUPLE_PARAM; arg: TUPLE): STRING
		local
			etf_local_i : INTEGER
		do
			from
				create Result.make_empty
				Result.append ("[")
				etf_local_i := 1
			until
				etf_local_i > arg.count
			loop
				if attached {ANY} arg[etf_local_i] as arg_value then
					Result.append (etf_arg_out (param.base_types[etf_local_i].type, arg_value))
				end

				if etf_local_i < arg.upper then
					Result.append (", ")
				end
				etf_local_i := etf_local_i + 1
			end
			Result.append ("]")
		end

	retrieve_named_type_if_necessary (param_type: ETF_PARAM_TYPE): ETF_PARAM_TYPE
			-- Retrieve the PARAM_TYPE that the named type refers to.
		do
			if attached {ETF_NAMED_PARAM_TYPE} param_type as npt then

				Result := npt.type
			else
				Result := param_type
			end
		end
end