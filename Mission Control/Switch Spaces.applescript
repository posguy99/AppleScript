do shell script "/Applications/Mission\\ Control.app/Contents/MacOS/Mission\\ Control"
delay 0.5
try
    tell application "System Events" to click (first button whose value of attribute "AXDescription" is "exit to Desktop 2") ¬
      of list 1 of group 1 of process "Dock"
on error
    tell application "System Events" to click (first button whose value of attribute "AXDescription" is "exit to Desktop 2") ¬
      of list 2 of group 1 of process "Dock"

end try


-- this seems to work in 10.12.5, while the above does not...

do shell script "/Applications/Mission\\ Control.app/Contents/MacOS/Mission\\ Control"
delay 0.5
try
    tell application "System Events" to click (first button whose value of attribute "AXDescription" is "exit to Desktop 2") ¬
      of list 1 of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
end try
