note
	description: "Singleton access to the default business model."
	author: "Andres Rojas and Victor Vavan"

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
