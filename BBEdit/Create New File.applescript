try
	tell application "Finder"
		
		set opn to 0
		set fn to "new.txt"
		
		set answer to text returned of (display dialog "Filename to create:" default answer fn)
		
		if answer is "/" then
			set opn to 1
		else if character -1 of answer is "/" then
			set fn to text 1 thru -2 of answer
			set opn to 1
		else
			set fn to answer
		end if
		
		if character -1 of answer is "." then
			set fn to answer & "txt"
		end if
		
		try
			set p to target of window 1
		on error
			set p to desktop as alias
		end try
		set f to make new file at p with properties {name:fn}
		set selection to f
		if opn is 1 then
			open f using (path to application "BBEdit")
		end if
	end tell
end try
