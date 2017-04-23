
-- from http://daringfireball.net/2003/02/save_and_restore_safari_urls

-- get path to prefs file where URLs are stored
set prefs_folder to path to preferences folder as string
set prefs_file to prefs_folder & "Safari Saved URLs"

try
    set open_file to ¬
        open for access file prefs_file without write permission
    set url_list to read open_file using delimiter return
    close access open_file
    tell application "Safari"
        repeat with the_url in url_list
            open location the_url
        end repeat
    end tell
on error
    try
        close access file prefs_file
    end try
end try
