tell application "Finder"
	try
		-- open location ("afp://DiskStation.local/Archive")
		-- open location ("afp://DiskStation.local/Documents")
		-- open location ("afp://DiskStation.local/Media")
		mount volume "afp://DiskStation.local/Archive"
		mount volume "afp://DiskStation.local/Documents"
		mount volume "afp://DiskStation.local/Media"
		mount volume "afp://DiskStation.local/Pictures"
	on error number n
		display alert ("Error " & n & " on network share mount")
	end try
end tell

