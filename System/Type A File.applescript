
# stupid script to get around not being able to paste into NetLab VM
# it mostly works but man, does VS Code have problems with tabs

set theFile to choose file with prompt "Please select a file:"

# Read lines from file.
set lns to paragraphs of (read file theFile as «class utf8»)

# NetLab is open in Safari
tell application "Safari" to activate

tell application "System Events"
    delay 1
    repeat with ln in lns
        delay 1
        keystroke ln
        delay 1
        keystroke Return
    end repeat
end tell
