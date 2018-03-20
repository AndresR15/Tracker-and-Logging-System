note
	description: "Summary description for {ROOT}."
	author: "JSO and Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_GUI_ROOT_INTERFACE

feature -- Commands
	show_history
			-- When the GUI is launched, show the history panel
			-- which displays the trace of events.
		do
			is_history_shown := TRUE
		end

	hide_history
			-- When the GUI is launch, do not show the history panel.
		do
			is_history_shown := FALSE
		end

feature {NONE} -- Attributes
	gui: detachable ETF_GUI

	is_history_shown: BOOLEAN

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create gui
			check attached gui as g then
				if is_history_shown then
					g.main_window.history.show
				else
					g.main_window.history.hide
				end
				g.launch
			end
		end
end


