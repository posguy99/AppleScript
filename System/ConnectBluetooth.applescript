--
-- from https://superuser.com/questions/468556/applescript-to-connect-to-bluetooth-device
--

activate application "SystemUIServer"
tell application "System Events"
    tell process "SystemUIServer"
        -- Working CONNECT Script.  Goes through the following:
        -- Clicks on Bluetooth Menu (OSX Top Menu Bar)
        --    => Clicks on device Item
        --      => Clicks on Connect Item
        set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
        tell btMenu
            click
            tell (menu item "Echo-4NL" of menu 1)
                click
                if exists menu item "Connect" of menu 1 then
                    click menu item "Connect" of menu 1
                    return "Connecting..."
                else
                    key code 53 -- Close main BT drop down if Connect wasn't present
                    return "Connect menu was not found, are you already connected?"
                end if
            end tell
        end tell
    end tell
end tell


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
