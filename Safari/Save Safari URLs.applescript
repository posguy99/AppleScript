
-- from http://daringfireball.net/2003/02/save_and_restore_safari_urls

tell application "Safari"
    set url_list to URL of every document
end tell

-- convert url_list to text
set old_delim to AppleScript's text item delimiters
set AppleScript's text item delimiters to return
set url_list to url_list as text
set AppleScript's text item delimiters to old_delim

-- get path to prefs file where URLs will be stored
set prefs_folder to path to preferences folder as string
set prefs_file to prefs_folder & "Safari Saved URLs"

try
    set open_file to ¬
        open for access file prefs_file with write permission
    -- erase current contents of file:
    set eof of open_file to 0
    write url_list to open_file starting at eof
    close access open_file
on error
    try
        close access file prefs_file
    end try
end try
