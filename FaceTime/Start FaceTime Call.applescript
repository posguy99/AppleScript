--
-- From https://apple.stackexchange.com/questions/189774/make-a-facetime-call-using-applescript
-- and
-- https://apple.stackexchange.com/questions/234291/making-a-facetime-audio-call-using-applescript
--

set phone_num to text returned of (display dialog "Input a phone number to call:" default answer "")
-- facetime:// is a facetime video call
-- facetime-audio:// is a facetime audio call
-- tel:// is a regular telephone call via Continuity
do shell script "open facetime://" & quoted form of phone_num
tell application "System Events"
    repeat until (button "Call" of window 1 of application process "FaceTime" exists)
        delay 1
    end repeat
    click button "Call" of window 1 of application process "FaceTime"
end tell
