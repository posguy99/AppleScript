
-- This script adds the selected message to Things as a new todo
-- by default the completion date is set to seven days from today

-- msw 092814

tell application "Mail"
	set selectedMessages to selection
	if (count of selectedMessages) is equal to 0 then
		display alert "No Messages Selected" message "Select the message you want to add to Things before running this script."
	else
		set theMessage to item 1 of selectedMessages
		set taskName to subject of theMessage
		set taskNotes to content of theMessage
		tell application "Things.app"
			set newToDo to make new «class tstk» with properties {name:taskName, «class note»:taskNotes}
			set «class dued» of newToDo to (current date) + 7 * days
			-- set completion date of newToDo to current date
			set «class tnam» of newToDo to "from email"
		end tell
	end if
end tell
