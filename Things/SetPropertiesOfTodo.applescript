tell application "Things3"
set newToDo to make new to do ¬
with properties {name:"New to do", due date:current date} ¬ at beginning of list "Anytime"
set name of newToDo to "This task has been renamed"
set notes of newToDo to "http://www.cultured.com/" & linefeed & "call Werner for more details" set due date of newToDo to (current date) + 7 * days
set completion date of newToDo to current date
set tag names of newToDo to "Home, Mac"
end tell
tell application "Things3"
-- adding to dos with links to files
set newToDo to make new to do with properties {name:"New to do", notes: "[filepath=/Users/bartek/ Downloads/Xcode_8_beta.xip]This is a link to Xcode 8[/filepath]"} ¬
at beginning of list "Today" -- adding to dos in lists
set newToDo to make new to do with properties {name:"New to do", due date:current date} ¬ at beginning of list "Today"
tell list "Someday"
set newToDo to make new to do ¬
with properties {name:"New to do for someday"} -- adding to dos in projects
set newToDo to make new to do ¬
with properties {name:"New Things feature", due date:current date} ¬ at beginning of project "Things"
tell project "Things"
set newToDo to make new to do ¬
end tell
with properties {name:"New Things feature"} -- adding to dos in areas
set newToDo to make new to do ¬
with properties {name:"New personal to do"} ¬ at beginning of area "Personal"
tell area "Personal"
set newToDo to make new to do with properties {name:"New personal to do"}
end tell
-- adding delegated to dos
set newToDo to make new to do ¬
with properties {name:"New delegated to do"} ¬ at beginning of contact "Steve Jobs"
tell contact "Steve Jobs"

end tell
set newToDo to make new to do ¬
with properties {name:"New delegated to do"}
end tell end tell
