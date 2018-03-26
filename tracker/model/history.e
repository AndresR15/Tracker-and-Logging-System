note
	description: "Summary description for {HISTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

Create
	make

feature {NONE} --Instantiation

	make
		do
			create record.make
		end

feature {HISTORY} -- Attributes

	record: LINKED_LIST [COMMAND]

feature -- Deleation

	reset_list
		do
			record.wipe_out
		end

feature -- Setters

	add_to_record (c: COMMAND)
		do
			record.extend (c)
		end

feature -- Getters

	get_record: LINKED_LIST [COMMAND]
		do
			Result := record
		end

end
