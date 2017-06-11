
-- from https://apple.stackexchange.com/questions/135728/using-applescript-to-lock-screen

tell application "System Events" to tell process "SystemUIServer"
    tell (menu bar item 1 of menu bar 1 where description is "Keychain menu extra")
        click
        click menu item "Lock Screen" of menu 1
    end tell
end tell
