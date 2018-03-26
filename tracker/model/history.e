note
	description: "Summary description for {HISTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create record.make
		end

feature {NONE} -- atributes

	record: LINKED_LIST [COMMAND]

feature -- commands

	add_record (c: COMMAND)
		do
			record.extend (c)
		end
end
