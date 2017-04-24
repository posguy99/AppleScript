
-- from https://hea-www.harvard.edu/~fine/OSX/safari-tabs.html

set question to display dialog ("Find Safari tab:") default answer ""
set searchpat to text returned of question

tell application "Safari"
	set winlist to every window
	set winmatchlist to {}
	set tabmatchlist to {}
	set tabnamematchlist to {}
	repeat with win in winlist
		set ok to true
		try
			set tablist to every tab of win
		on error errmsg
			--display dialog name of win as string
			set ok to false
		end try
		if ok then
			repeat with t in tablist
				if searchpat is in (name of t as string) then
					set end of winmatchlist to win
					set end of tabmatchlist to t
					set end of tabnamematchlist to (id of win as string) & "." & (index of t as string) & ".  " & (name of t as string)
					--display dialog name of t as string
				else if searchpat is in (URL of t as string) then
					set end of winmatchlist to win
					set end of tabmatchlist to t
					set end of tabnamematchlist to (id of win as string) & "." & (index of t as string) & ".  " & (name of t as string)
					--display dialog name of t as string
				end if
			end repeat
		end if
	end repeat
	if (count of tabmatchlist) = 1 then
		--display dialog "one!"
		set w to item 1 of winmatchlist
		set t to item 1 of tabmatchlist
		set current tab of w to t
		set index of w to 1
	else if (count of tabmatchlist) = 0 then
		display dialog "No matches"
	else
		set whichtab to choose from list of tabnamematchlist with prompt "The following tabs match, please select one:"
		set AppleScript's text item delimiters to "."
		if whichtab is not equal to false then
			set tmp to text items of (whichtab as string)
			set w to (item 1 of tmp) as integer
			set t to (item 2 of tmp) as integer
			set current tab of window id w to tab t of window id w
			set index of window id w to 1
		end if
	end if
end tell
