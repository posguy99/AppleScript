#!/bin/bash

mytext=$(/usr/bin/osascript << EOT
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
return theSource
EOT)

if [ $? -eq 0 ]
then
    mate --type text.mail.markdown --no-recent --name "Raw Mail Message" <<< "$mytext"
else
    echo "User canceled"
fi
