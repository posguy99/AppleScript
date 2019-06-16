--
-- based on https://superuser.com/questions/468556/applescript-to-connect-to-bluetooth-device
--

activate application "SystemUIServer"
tell application "System Events"
    tell process "SystemUIServer"
        -- Working CONNECT Script.  Goes through the following:
        -- Clicks on Volume Menu (OSX Top Menu Bar)
        --    => Clicks on device Item
        set vMenu to (menu bar item 1 of menu bar 1 whose description contains "volume")
        tell vMenu
            click
            tell (menu item "Echo-4NL" of menu 1)
                click
                return
            end tell
        end tell
    end tell
end tell
