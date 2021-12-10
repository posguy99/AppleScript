tell application "Finder"
	set temp to selection as alias
end tell
set posixPathName to POSIX path of temp
set myHome to POSIX path of (path to home folder)
set result to get replaceText(myHome, "~/", posixPathName)
set the clipboard to result
return

on replaceText(find, replace, subject)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set subject to text items of subject
	
	set text item delimiters of AppleScript to replace
	set subject to subject as text
	set text item delimiters of AppleScript to prevTIDs
	
	return subject
end replaceText
