
-- from https://forum.keyboardmaestro.com/t/macro-to-quickly-close-all-safari-tabs-except-pinned-and-current-one/4177/14

tell application "System Events"
   tell application process "Safari"
      tell front window
         tell tab group 1
            set pinnedTabList to name of radio buttons whose role description is "pinned tab"
         end tell
      end tell
   end tell
end tell

-- close all but the pinned tabs

tell application "Safari"
   tell front window
      (name of tabs)
      repeat with theTab in (get name of tabs)
         if theTab is not in pinnedTabList then
            close tab theTab
         end if
      end repeat
   end tell
end tell
