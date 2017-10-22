
-- obviously the path below is an example

tell application "Finder"
    if (exists of POSIX file "/Applications/Utilities") is true then
        display dialog "Folder exists."
    else
        display dialog "Folder does not exist."
    end if
end tell
