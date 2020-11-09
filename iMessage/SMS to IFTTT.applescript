-- Send SMS via Messages.app to IFTTT
-- toggles state off Office switch
-- this only works on 10.10 and only if the iPhone is available to send the SMS

-- msw 111614

tell application "Messages"

	set targetBuddy to "+14152372232"
	set targetService to "SMS"

	set textMessage to "#officetoggle"
	set theBuddy to buddy targetBuddy of service targetService
	send textMessage to theBuddy

end tell
