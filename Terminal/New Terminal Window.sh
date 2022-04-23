#!/bin/sh

# open a new Terminal window with the default profile

osascript <<EOF
tell application "Terminal"
    do script ""
    activate
end tell
EOF
