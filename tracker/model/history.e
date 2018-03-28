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

	reset_record
		do
			record.wipe_out
		end

	remove_all_right
            --remove all items to the right of the cursor
        require
            cursor_not_last: not get_record.islast
        do

            from
            until
                record.islast
            loop

                record.remove_right
            end
        end

feature -- Traverse


feature -- Setters

	add_to_record (c: COMMAND)
		-- add a COMMAND object to record
		do
			remove_all_right
			record.extend (c)
			record.forth
		end

feature -- Getters

	get_record: LINKED_LIST [COMMAND]
		do
			Result := record
		end

end
