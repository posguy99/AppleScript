-- Downloaded From: http://c-command.com/scripts/finder/open-in-bbedit
-- Last Modified: 2010-11-27

on run
	tell application "Finder"
		set _list to {}
		set _items to selection
		if _items is {} then
			set _folder to folder of the front window as string
			copy _folder to end of _list
		else
			repeat with _item in _items
				set _item to _item as alias
				copy _item to end of _list
			end repeat
		end if
	end tell
	bb(_list)
end run

on open (_list)
	bb(_list)
end open


on bb(_list)
	tell application "BBEdit"
		open _list
		activate
	end tell
end bb
