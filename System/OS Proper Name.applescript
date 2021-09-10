set _delim to AppleScript's text item delimiters
set AppleScript's text item delimiters to "."
set os_version to the second item of (the text items of (do shell script "sw_vers -productVersion"))
set AppleScript's text item delimiters to _delim


set osList to { "Cheetah", "Puma", "Jaguar", "Panther", "Tiger", "Leopard", "Snow Leopard",¬
                "Lion", "Mountain Lion", "Mavericks", "Yosemite", "El Capitan", "Sierra", "High Sierra", "Mojave", "Catalina"}

return item (os_version+1) of osList
