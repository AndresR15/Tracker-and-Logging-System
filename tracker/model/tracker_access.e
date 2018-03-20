note
	description: "Singleton access to the default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	TRACKER_ACCESS

feature
	m: TRACKER
		once
			create Result.make
		end

invariant
	m = m
end




