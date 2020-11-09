-- Version 2.0, (C) Ergonis Software, 2015-09-22
-- Feel free to modify the script for your own use, but leave the copyright notice intact.

try
	tell application "Safari"
		if it is running then
			-- return URL of document 1
            return URL of front document
		else
			return "(Safari is not running)"
		end if
	end tell
on error
	return "(Safari URL not available)"
end try
