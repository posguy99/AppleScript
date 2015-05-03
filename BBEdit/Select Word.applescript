tell application "BBEdit"
	tell window 1
		set sel_offset to characterOffset of selection
		set cur_line to startDisplayLine of selection
		try
			select (last word of display_line cur_line ¬
				whose characterOffset ≤ sel_offset)
		on error
			select display_line cur_line
		end try
	end tell
end tell
