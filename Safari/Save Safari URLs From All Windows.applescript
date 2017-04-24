
-- based on http://daringfireball.net/2003/02/save_and_restore_safari_urls
-- this one looks at all open windows

tell application "Safari"
    set urlList to ""
	set windowCount to number of windows

	-- repeat for every window
	repeat with x from 1 to windowCount
		set tabCount to number of tabs in window x
		-- repeat for every tab in this window
		repeat with y from 1 to tabCount
			-- get tab URL
			set tabURL to URL of tab y of window x
            set urlList to urlList & (tabURL as text) & return
		end repeat
	end repeat
end tell

-- convert url_list to text
-- set old_delim to AppleScript's text item delimiters
-- set AppleScript's text item delimiters to return
-- set urlList to urlList as text
-- set AppleScript's text item delimiters to old_delim

-- get path to prefs file where URLs will be stored
set prefs_folder to path to preferences folder as string
set prefs_file to prefs_folder & "Safari Saved URLs"

try
    set open_file to ¬
        open for access file prefs_file with write permission
    -- erase current contents of file:
    set eof of open_file to 0
    write urlList to open_file starting at eof
    close access open_file
on error
    try
        close access file prefs_file
    end try
end try


