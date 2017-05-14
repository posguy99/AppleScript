
-- From https://gist.github.com/drdrang/480831c3eb35d5a66b5d681e881bdef3

set remindersOpen to application "Reminders" is running
set monthAgo to (current date) - (30 * days)

tell application "Reminders"
	set myLists to name of every list
	repeat with thisList in myLists
		tell list thisList
			delete (every reminder whose completion date is less than monthAgo)
		end tell
	end repeat
	if not remindersOpen then quit
end tell
