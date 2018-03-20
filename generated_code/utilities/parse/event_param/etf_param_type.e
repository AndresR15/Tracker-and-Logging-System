note
	description: "Summary description for {ETF_PARAM_TYPE}."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_PARAM_TYPE

feature -- Query
	eiffel_type: STRING
			-- Representation as a valid Eiffel type.
			-- The 'out' feature, on the other hand, may give
			-- more information about the parameter type.
			-- e.g., out = "1..10" and eiffel_type = "INTEGER_64"
		deferred end

	create_clause: STRING
			-- Creation instruction needed to recreate the current type.
		deferred end
end


