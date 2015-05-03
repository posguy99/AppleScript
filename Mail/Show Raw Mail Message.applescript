
set theSource to {}
tell application "Mail"
	set selectedMessages to selection
	if selectedMessages is {} then
		display dialog "Please select a message first"
		error -128
	end if
	repeat with theMessage in selectedMessages
		set end of theSource to source of theMessage & return
	end repeat
end tell

set theScript to "/usr/local/bin/mate --type text.mail.markdown --no-recent --name " & quote & "Raw Mail Message" & quote & " <<< " & quote & theSource & quote

do shell script theScript

