-- Send SMS via Messages.app to IFTTT
-- turn all lights off
-- this only works on 10.10 and only if the iPhone is available to send the SMS

-- msw 112914

tell application "Messages"
	
	set targetBuddy to "+14152372232"
	set targetService to "SMS"
	
	set textMessage to "#alllightsoff"
	set theBuddy to buddy targetBuddy of service targetService
	send textMessage to theBuddy
	
end tell
