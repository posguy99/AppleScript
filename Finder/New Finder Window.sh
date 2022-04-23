#!/bin/sh

# open a new Terminal window with the default profile

osascript <<EOF
tell application "Finder"
    activate
    set newWindow to make new Finder window
end tell
EOF
