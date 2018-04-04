note
	description: "Summary description for {HISTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature {NONE} --Instantiation

	make
		do
			create record.make
		end

feature {HISTORY} -- Attributes

	record: LINKED_LIST [COMMAND]

feature -- Deleation

	reset_record_and_append(c: COMMAND)
		do
			record.wipe_out
			record.extend (c)
			record.finish
		end

	remove_all_right
            --remove all items to the right of the cursor
        do
            from
            until
                record.islast or else record.is_empty
            loop
            	if record.count /= record.index then
            		record.remove_right
            	end
            end
 		end

feature -- Traverse
--	move_right
--		do
--			if not record.after then
--				record.forth
--			
--			end
--		end

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
