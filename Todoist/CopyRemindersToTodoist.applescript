
set remindersOpen to application "Reminders" is running

set todoistToken to "b72150682f676f4f5dec879ea0c148baddc32f83"
set apiCall to "curl https://api.todoist.com/sync/v8/quick/add"

tell application "Reminders"

	set theLists to the name of every list
	set ListOfReminders to (choose from list theLists) as text

	-- set ListOfReminders to "Test"
	set notCompleted to reminders in list ListOfReminders whose completed is false

	repeat with currentReminder in notCompleted

		-- create title of task
		set _tmp to (get name of currentReminder)
		set taskTitle to " -d text=" & "'" & _tmp

		-- get the priority
		set temp to (get priority of currentReminder)
		set thePriority to 4
		if (temp = 0) then
			set thePriority to 4
		else if (temp = 9) then
			set thePriority to 3
		else if (temp = 5) then
			set thePriority to 2
		else if (temp = 1) then
			set thePriority to 1
		end if
		set taskTitle to (taskTitle & " p" & thePriority)

		-- is there a due date?
		set _tmp to (get due date of currentReminder as text)

		-- remove the commas
		set _tmp to my findAndReplaceInText(_tmp, ",", "")

		-- now we need to fix the time on the end
		set _tmp to my findAndReplaceInText(_tmp, ":00 AM", " AM")
		set _tmp to my findAndReplaceInText(_tmp, ":00 PM", " PM")

		if _tmp is not equal to "" then set taskTitle to (taskTitle & " on " & _tmp)
		set taskTitle to (taskTitle & "'")

		-- is there a reminder date and time?
		set taskReminder to ""
		set _tmp to (get remind me date of currentReminder as text)

		-- remove the commas
		set _tmp to my findAndReplaceInText(_tmp, ",", "")

		-- now we need to fix the time on the end
		set _tmp to my findAndReplaceInText(_tmp, ":00 AM", " AM")
		set _tmp to my findAndReplaceInText(_tmp, ":00 PM", " PM")

		if _tmp is not equal to "" then set taskReminder to " -d reminder=" & "'" & _tmp & "'"

		set unencodedText to (get body of currentReminder)
		set _tmp to my encode_text(unencodedText, true, true)
		set taskBody to " -d note=" & "'" & _tmp & "'"

		set postToAPI to apiCall & " -d token='" & todoistToken & "'" & taskTitle & taskReminder & taskBody
		set _result to (do shell script postToAPI)

	end repeat

	if not remindersOpen then quit

end tell

-- A sub-routine for encoding high-ASCII characters
-- From http://www.macosxautomation.com/applescript/sbrt/sbrt-08.html

on encode_char(this_char)
	set the ASCII_num to (the ASCII number this_char)
	set the hex_list to {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}
	set x to item ((ASCII_num div 16) + 1) of the hex_list
	set y to item ((ASCII_num mod 16) + 1) of the hex_list
	return ("%" & x & y) as string
end encode_char

-- this sub-routine is used to encode text
-- From http://www.macosxautomation.com/applescript/sbrt/sbrt-08.html
-- for definitions of encode_URL_A and encode_URL_B see above URL

on encode_text(this_text, encode_URL_A, encode_URL_B)
	set the standard_characters to "abcdefghijklmnopqrstuvwxyzõäöü0123456789"
	set the URL_A_chars to "$+!'/?;&@=#%><{}[]\"~`^\\|*"
	set the URL_B_chars to ".-_:"
	set the acceptable_characters to the standard_characters
	if encode_URL_A is false then set the acceptable_characters to the acceptable_characters & the URL_A_chars
	if encode_URL_B is false then set the acceptable_characters to the acceptable_characters & the URL_B_chars
	set the encoded_text to ""
	repeat with this_char in this_text
		if this_char is in the acceptable_characters then
			set the encoded_text to (the encoded_text & this_char)
		else
			set the encoded_text to (the encoded_text & encode_char(this_char)) as string
		end if
	end repeat
	return the encoded_text
end encode_text

on findAndReplaceInText(theText, theSearchString, theReplacementString)
	set AppleScript's text item delimiters to theSearchString
	set theTextItems to every text item of theText
	set AppleScript's text item delimiters to theReplacementString
	set theText to theTextItems as string
	set AppleScript's text item delimiters to ""
	return theText
end findAndReplaceInText
