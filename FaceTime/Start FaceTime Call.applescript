--
-- From https://apple.stackexchange.com/questions/189774/make-a-facetime-call-using-applescript
--


set phone_num to text returned of (display dialog "Input a phone number to call:" default answer "")
do shell script "open facetime://" & quoted form of phone_num
tell application "System Events"
    repeat until (button "Call" of window 1 of application process "FaceTime" exists)
        delay 1
    end repeat
    click button "Call" of window 1 of application process "FaceTime"
end tell
