
-- from http://daringfireball.net/2003/02/save_and_restore_safari_urls

display dialog ¬
    "Clear stored Safari URL list?" buttons {"Cancel", "Clear"} ¬
    default button 2 with icon note

if button returned of result is "Clear" then
    -- get path to prefs file where URLs will be stored
    set prefs_folder to path to preferences folder as string
    set prefs_file to prefs_folder & "Safari Saved URLs"

    try
        set open_file to ¬
            open for access file prefs_file with write permission
        -- erase current contents of file:
        set eof of open_file to 0
        close access open_file
    on error
        try
            close access file prefs_file
        end try
    end try
end if
