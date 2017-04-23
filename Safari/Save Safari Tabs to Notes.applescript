
-- from MacOS Scripting

property defaultAccountName : "iCloud"
property defaultFolderName : "Saved Safari Windows"

global html
global processedURLs

on appendLineWithDoc(theDoc)
	tell application "Safari"
		tell theDoc
			try
				my appendHTML("    <li>")
				my appendHTML("<a href=\"" & URL & "\">")
				my appendHTML(name)
				my appendHTML("</a></li>" & return)
				set processedURLs to processedURLs & (URL as string)
			end try
		end tell
	end tell
end appendLineWithDoc

on appendHTML(htmlString)
	set html to html & htmlString
end appendHTML

on defaultFolder()
	tell application "Notes"
		if not (exists account defaultAccountName) then
			display dialog "Cound not find account '" & defaultAccountName & "'!"
			tell me to quit
		end if

		if exists folder defaultFolderName of account defaultAccountName then
			return folder defaultFolderName of account defaultAccountName
		end if

		make new folder at account defaultAccountName with properties {name:defaultFolderName}
	end tell
end defaultFolder

on run
	set datestamp to "Saved on " & (short date string) of (current date) & " at " & (time string) of (current date) & return
	set html to "<h1>" & datestamp & "</h1>" & return
	my appendHTML("<ul>" & return)
	set processedURLs to {}

	tell application "Safari"
		activate
		set w to window 1

		set n to 0
		try -- this will fail for the downloads window
			set n to count tabs of w
		end try

		if n > 1 then
			repeat with t in every tab of w
				my appendLineWithDoc(t)
			end repeat
		else if n = 1 then
			my appendLineWithDoc(document of w)
		end if
	end tell

	my appendHTML("</ul>" & return)

	if (count of processedURLs) > 0 then
		set f to my defaultFolder()
		tell application "Notes"
			make new note at f with properties {body:html, name:datestamp}
			activate
		end tell
	end if
end run
