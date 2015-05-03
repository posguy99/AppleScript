property msgTitle : "    Export selected emails to a folder    "
property fileExtention : ".eml"
property maxNameLength : 245
property creatorID : "emal" -- Apple Mail. Could also be set for thunderbird, eudora, entourage etc.

using terms from application "Mail"
	on perform mail action with messages messageList
		if length of messageList is not 0 then
			copy messageList to myMessages
			display dialog "Export selected message(s) as Raw Source to " & fileExtention & " files?" with title msgTitle with icon note
			if the button returned of the result is "OK" then
				set theFolder to choose folder with prompt "Save Exported Messages to..." without invisibles
				set ctr to 0
				set doneCtr to 0
				
				-- Loop through the selected messages
				repeat with theMessage in myMessages
					set ctr to ctr + 1
					-- Strip out any illegal characters from the subject line
					set exportFile to (((theFolder) as Unicode text) & CleanName((subject of theMessage) as Unicode text))
					
					-- Check that filename is not already taken, if so overwrite or increment counter to create new file name
					set incCtr to 0
					copy {exportFile, exportFile} to {nameStem, tempName}
					set msgResponse to "Overwrite" -- set this as default so user isn't prompted during incremental checks for new name
					
					repeat while DoesFileExist(tempName & fileExtention) = 1
						if msgResponse is not equal to "Rename" then
							set msgResponse to (the button returned of (display dialog "The file:" & return & return & tempName & fileExtention & return & return & "already exists. Overwrite it?" buttons {"Cancel", "Overwrite", "Rename"} default button 2 with title msgTitle))
						end if
						if msgResponse = "Cancel" then
							return
						else if msgResponse = "overwrite" then
							exit repeat --use the existing name and overwrite it
						else
							set incCtr to incCtr + 1
							set tempName to nameStem & incCtr
						end if
					end repeat
					
					set exportFile to tempName & fileExtention
					
					set theSource to (source of theMessage)
					
					try
						set theFileID to open for access exportFile with write permission
						set eof of the theFileID to 0 -- ensure any existing file data is wiped (in overwrite mode)
						write theSource to theFileID -- starting at eof
						close access theFileID
						setCreator(exportFile, creatorID) --attempt to set file creator, don't complain on error
						set doneCtr to doneCtr + 1
					on error e number n from f to t
						set errMsg to "Can't write message" & return & "Error " & e & return & "Number " & n
						log errMsg
						display dialog errMsg
						try
							close theFileID
						end try
					end try
					
				end repeat
				if the button returned of (display dialog "Successfully exported " & doneCtr & " of " & ctr & " messages." & return & return & "Destination folder:" & return & (theFolder as string) buttons {"OK", "Open Folder"} default button 1 with title msgTitle with icon note) = "Open Folder" then
					tell application "Finder" to open folder theFolder
				end if
			end if
		end if
	end perform mail action with messages
end using terms from

using terms from application "Mail"
	on run
		tell application "Mail" to set mySelection to selection
		tell me to perform mail action with messages (mySelection)
	end run
end using terms from


-- ==| FUNCTIONS |== --
-- Function to remove all but permitted characters from a string and truncate if necessary to the maxNameLength property defined at the top of the script.
to CleanName(theName)
	set resultString to ""
	-- List of all the characters allowed. Anything not in this list will be removed from the resultString. Comparison is case-insensitive.
	set goodChars to {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "_", " "}
	repeat with i from 1 to the length of theName
		if item i of theName is in goodChars then
			set resultString to resultString & character i of theName
		else
			set resultString to resultString & "_"
		end if
	end repeat
	if the length of resultString > maxNameLength then
		set resultString to (characters 1 through maxNameLength of resultString) as Unicode text
	end if
	return resultString
end CleanName


on DoesFileExist(filePath)
	tell application "Finder"
		if exists file filePath then
			return 1
		else
			return 0
		end if
	end tell
end DoesFileExist


to setCreator(filePath, creatorType)
	tell application "Finder"
		try
			set the creator type of file filePath to creatorType
		on error
			log "Could not set creator type"
		end try
	end tell
end setCreator


