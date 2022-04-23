#!/bin/sh

# open a new Chrome window using default window parameters

osascript <<EOF
tell application "Google Chrome"
    tell (make new window)
    end tell
    activate
end tell
EOF
