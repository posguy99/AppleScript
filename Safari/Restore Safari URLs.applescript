
-- from http://daringfireball.net/2003/02/save_and_restore_safari_urls
-- from http://stackoverflow.com/questions/11706171/how-to-open-a-new-window-and-multiple-urls-in-safari-with-apple-script

-- get path to prefs file where URLs are stored
set prefs_folder to path to preferences folder as string
set prefs_file to prefs_folder & "Safari Saved URLs"

try
	set open_file to ¬
		open for access file prefs_file without write permission
	set tempList to read open_file using delimiter return
	close access open_file

	-- ok, have the list in tempList, need to make the list unique

	set urlList to {}
	repeat with x from 1 to count of items of tempList
		if item x of tempList is not in urlList then
			set urlList to urlList & item x of tempList
		end if
	end repeat

    tell application "Safari"
        if urlList = {} then
            -- If you don't want to open a new window for an empty list, replace the
            -- following line with just "return"
            set {first_url, rest_urls} to {"", {}}
        else
            -- `item 1 of ...` gets the first item of a list, `rest of ...` gets
            -- everything after the first item of a list.  We treat the two
            -- differently because the first item must be placed in a new window, but
            -- everything else must be placed in a new tab.
            set {first_url, rest_urls} to {item 1 of urlList, rest of urlList}
        end if

        make new document at end of documents with properties {URL:first_url}
        tell window 1
            repeat with the_url in rest_urls
                make new tab at end of tabs with properties {URL:the_url}
            end repeat
        end tell
    end tell

    -- tell application "Safari"
    --         make new window
    --     tell window 1
    --         repeat with the_url in urlList
    --             set current tab to (make new tab with properties {URL:the_url})
    --         end repeat
    --     end tell
    -- end tell

on error
	try
		close access file prefs_file
	end try
end try
