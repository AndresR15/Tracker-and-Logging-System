note
	description: "Summary description for {MATERIAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	MATERIAL

feature -- conversion

	int_to_material_string (int: INTEGER_64): STRING
			-- convert INTEGER_64 to a MATERIAL
		require
			valid_mat: int > 0 and int < 5
		do
			inspect int
			when 1 then
				Result := "glass"
			when 2 then
				Result := "metal"
			when 3 then
				Result := "plastic"
			when 4 then
				Result := "liquid"
			else
				Result := ""
			end
		end
end
