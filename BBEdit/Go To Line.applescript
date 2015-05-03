set line_number to text returned of ¬
	(display dialog ¬
		"Line" with title ¬
		"Go To Line" default answer ¬
		"1" buttons {"Cancel", "Go To"} ¬
		default button 2 ¬
		with answer)

tell application "BBEdit" to tell window 1
	--set the text of window 1 to line_number
	if (line_number is "0") then
		set line_number to count lines
	end if
	--select line (line_number as integer)
	--select insertion point after (character (1) of line line_number)
	select insertion point before line (line_number as integer)
end tell
