
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
    set theMessage to make new outgoing message with properties {content:theSource, visible:true}
end tell


