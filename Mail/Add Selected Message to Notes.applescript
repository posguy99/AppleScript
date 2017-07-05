
-- This script adds the selected message to Notes.app

-- msw 070417

property defaultAccountName : "iCloud"
property defaultFolderName : "Email"

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
    tell application "Mail"
        set selectedMessages to selection
	    if (count of selectedMessages) is equal to 0 then
            display alert "No Messages Selected" message "Select the message you want to add first."
        else
            set theMessage to item 1 of selectedMessages
            set theTitle to subject of theMessage
            set theNote to content of theMessage
            tell application "Notes"
                set f to my defaultFolder()
                make new note at f with properties {body:theNote, name:theTitle}
            end tell
        end if
    end tell
end run

