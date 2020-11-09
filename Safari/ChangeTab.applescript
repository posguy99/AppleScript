
-- from https://apple.stackexchange.com/questions/356772/applescript-next-previous-tab-in-safari

tell application "Safari"
    tell window 1
        set currentTab to (get index of current tab)
        set current tab to tab (currentTab  - 1)
    end tell
end tell
