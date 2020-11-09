
tell application "Things3"
    set theList to []
    set todayToDos to to dos of list "Today"
    set listSize to count of todayToDos
    repeat with i from 1 to (listSize as number)
        set theList to TheList & (name of todayToDos's item i)
    end repeat
end tell
return theList
