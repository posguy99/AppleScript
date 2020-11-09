
tell application "Reminders"
    set ListOfReminders to "Comic Con"
    set notCompleted to reminders in list ListOfReminders whose completed is false
    repeat with currentReminder in notCompleted
        display dialog (get name of currentReminder)
    end repeat
end tell
