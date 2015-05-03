
-- This script adds all selected messages to Things as individual todo's
-- by default the completion date is set to seven days from today

-- msw 092814

tell application "Mail"
	set selectedMessages to selection
	if (count of selectedMessages) is equal to 0 then
		display alert "No Messages Selected" message "Select the messages you want to add to Things before running this script."
	else
		repeat with eachMessage in selectedMessages
			set taskName to subject of eachMessage
			set taskNotes to content of eachMessage
			tell application "Things.app"
				set newToDo to make new «class tstk» with properties {name:taskName, «class note»:taskNotes}
				set «class dued» of newToDo to (current date) + 7 * days
				-- set completion date of newToDo to current date
				set «class tnam» of newToDo to "from email"
			end tell
		end repeat
	end if
end tell
