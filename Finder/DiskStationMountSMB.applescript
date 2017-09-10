tell application "Finder"
	try
		-- open location ("afp://DiskStation.local/Archive")
		-- open location ("afp://DiskStation.local/Documents")
		-- open location ("afp://DiskStation.local/Media")
		mount volume "smb://DiskStation.local/Archive"
		mount volume "smb://DiskStation.local/Documents"
		mount volume "smb://DiskStation.local/Media"
		mount volume "smb://DiskStation.local/Pictures"
	on error number n
		display alert ("Error " & n & " on network share mount")
	end try
end tell

