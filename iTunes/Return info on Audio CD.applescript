tell application "iTunes"
	repeat with i from 1 to the count of sources
		if kind of source i is audio CD then
			set theCD to audio CD playlist 1 of source i
			exit repeat
		end if
	end repeat
	
	set CDal to theCD's name
	set CDar to theCD's artist
	set CDye to theCD's year
	set CDge to theCD's genre
	set CDco to theCD's composer
	set CDdn to disc number of theCD
	set CDdc to disc count of theCD
	set CDcomp to theCD's composer
	set theTracks to tracks of theCD
	
end tell
