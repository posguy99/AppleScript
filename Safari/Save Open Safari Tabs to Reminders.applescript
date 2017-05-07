(*
◸ Veritrope.com
Save Safari Tabs to Reminders
VERSION 1.0
June 15, 2014

// UPDATE NOTICES
    ** Follow @Veritrope on Twitter, Facebook, Google Plus, and ADN for Update Notices! **

// SUPPORT VERITROPE!
    If this AppleScript was useful to you, please take a second to show your love here:
    http://veritrope.com/support

// SCRIPT INFORMATION AND UPDATE PAGE:
http://veritrope.com/code/export-all-safari-tabs-to-reminders

// TERMS OF USE:
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

// CHANGELOG:
1.00    INITIAL RELEASE

*)

--RESET VALUES
set currentTab to 0

--SET DATE STAMP
set the dateStamp to ((the current date) as string)
set listName to "Safari Tabs on " & the dateStamp

--PROCESS FRONTMOST SAFARI WINDOW
tell application "Safari"
    activate
    set safariWindow to the front window
    set successCount to 0
    set tabCount to (count of (tabs of safariWindow))

    --MAKE LIST WITH TIMESTAMP
    tell application "Reminders" to set theList to (make new list with properties {name:listName})

    --PROCESS TABS
    repeat with w in safariWindow
        try
            --GET TAB INFORMATION
            repeat with t in (tabs of w)
                set TabTitle to (name of t)
                set TabURL to (URL of t)

                --MAKE REMINDER
                tell application "Reminders"
                    tell theList
                        make new reminder with properties {name:TabTitle, body:TabURL}
                    end tell
                end tell

                --INCREMENT SUCCESS COUNT
                set successCount to (successCount + 1)

            end repeat
        end try
    end repeat
end tell

--NOTIFY RESULTS
my notification_Center(successCount, tabCount)

(*
======================================
// NOTIFICATION SUBROUTINE
======================================
*)

--NOTIFICATION CENTER
on notification_Center(successCount, itemNum)
    set Plural_Test to (successCount) as number

    if Plural_Test is -1 then
        display notification "No Tabs Exported!" with title "Send Safari Tabs to Reminders" subtitle "◸ Veritrope.com"

    else if Plural_Test is 0 then
        display notification "No Tabs Exported!" with title "Send Safari Tabs to Reminders" subtitle "◸ Veritrope.com"

    else if Plural_Test is equal to 1 then
        display notification "Successfully Exported " & itemNum & ¬
            " Tab to Reminders" with title "Send Safari Tabs to Reminders" subtitle "◸ Veritrope.com"

    else if Plural_Test is greater than 1 then
        display notification "Successfully Exported " & itemNum & ¬
            " Tabs to Reminders" with title "Send Safari Tabs to Reminders" subtitle "◸ Veritrope.com"
    end if

    set itemNum to "0"
    delay 1
end notification_Center
