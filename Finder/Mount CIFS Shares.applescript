-- mount CIFS shares.app
-- D Zurn
-- Edit the section below to add the specific shares you want to mount whenthe app is run.
-- The list of mounted volumes is good, the list of failed mounts sometimes includes 
--    mounts that really DID succeed. So, there's that.
-- After any share fails, you can say "yes" to the question to open the Terminal so you
--   can try to determine why it might not work. 
-- The script also opens the Volumes folder to see if there are 'failed' mount folders 
--   from previous attempts, cluttering up the folder.

-- No attempt is made to remove failed mount folders, as it's too risky for a simple Applescript.

----------------  START OF USER-EDITABLE VARIABLES  ---------------- 

-- Edit this list of volumes to add/remove desired disks
set diskPaths to {¬
	"afp://DiskStation.local/Media", ¬
	"afp://DiskStation.local/Documents", ¬
	"afp://DiskStation.local/Archive"}

----------------  END OF USER-EDITABLE VARIABLES  ---------------- 

set diskNames to {}

local myCR, myLine

set oldDelims to AppleScript's text item delimiters -- save their current state
set AppleScript's text item delimiters to {"/"} -- declare new delimiters

repeat with i from 1 to (count diskPaths)
	set myPieces to every text item of item i of diskPaths
	set myTempPieces to item (count myPieces) of myPieces
	
	-- Use SED to globally replace %20 with a space, for readability
	set end of diskNames to do shell script "echo " & quoted form of myTempPieces & "|sed 's/%20/ /g' "
end repeat

set AppleScript's text item delimiters to oldDelims -- restore them

set myCR to "

"
set myLine to "——————————"

tell application "Finder"
	set AppleScript's text item delimiters to ", "
	set userAborted to false
	
	set myExistingMounts to (list disks) ------ What do we have already mounted?
	
	set myFailedDisks to "" ------- Keep track of which disk we didn't mount
	set dialogText to ""
	
	repeat with i from 1 to (count diskNames) ------ Loop to mount the volumes
		set thisDiskName to item i of diskNames
		set thisDiskPath to item i of diskPaths
		set currentMounts to do shell script "mount" ----- Get a list of which volumes are currently mounted
		
		if (currentMounts) does not contain thisDiskName then
			-- display dialog ((list disks) as string)
			try
				-- mount volume (myPath & thisDiskPath)
				open location (thisDiskPath)
			on error number n
				display alert ("Error " & n & " for " & thisDiskName)
				if (n is -128) then
					set userAborted to true
					exit repeat
				end if
				if (n is not -35) then
					exit repeat
				end if
			end try
			delay 3
		end if -- if currentMounts does not contain thisDiskName
		
		-- Now check to see if the mounted volume shows up in the Finder...
		-- "list disks" shows us what the Finder thinks is mounted. Not the same as the mount results!
		if (list disks) does not contain thisDiskName then
			tell application "System Events"
				if (exists file ("/Volumes/" & thisDiskName & "/.autodiskmounted")) then
					set dialogText to "AutoDiskMounted volume " & thisDiskName & " found. Fix this." & myCR & myLine & myCR
				end if
			end tell
			
			-- The current disk isn't mounted for whatever reason, so put it in our list of non-mounted disks.
			if ((length of myFailedDisks) is 0) then
				set myFailedDisks to thisDiskName
			else
				set myFailedDisks to myFailedDisks & ", " & thisDiskName
			end if
		end if
		
		-- Continue with the rest of the disk in our list...	
	end repeat
	
	------ Figure out which disks we succeeded in mounting:
	set myFinishedMounts to (list disks)
	
	-- display dialog ((list disks) as string)
	set myNewMountText to ""
	repeat with myIndex from 1 to (count myFinishedMounts)
		set thisMount to item myIndex of myFinishedMounts
		-- display dialog (thisMount as string)
		if myExistingMounts does not contain thisMount then
			if ((length of myNewMountText) is 0) then
				set myNewMountText to thisMount
			else
				set myNewMountText to myNewMountText & ", " & thisMount
			end if
		end if
	end repeat
	
	if ((length of myNewMountText) is 0) then --------- No new mounts
		set dialogText to dialogText & "No additional volumes were mounted." & myCR
		
	else ----- we've got some new mounts
		set dialogText to dialogText & "These volume(s) were successfully mounted:" & myCR & myNewMountText
		
	end if
	
	if ((length of myFailedDisks) is 0) then
		
		------- No failed mounts, list the dialog text and stop
		activate
		display dialog dialogText
		
	else ------ At least 1 mount failed, so display the dialog we've been making and offer to open Terminal
		set dialogText to dialogText & myLine & myCR & "These volumes could not be mounted:"
		set dialogText to dialogText & myCR & myFailedDisks
		set dialogText to dialogText & myCR & "Open Terminal window?"
		try
			activate
			display dialog dialogText buttons {"Open Terminal", "Done"} default button "Done" giving up after 100
			set the user_choice to the button returned of the result
			if (user_choice is "Open Terminal") then
				tell application "Terminal"
					if window frontmost exists then
						tell window frontmost to activate
					end if
					do shell script "open /Volumes"
				end tell
			end if
			
		on error
			display dialog ("Could not open Terminal application")
		end try
	end if
	
end tell
