-- Version 1.0, (C) Ergonis Software, 2012-01-19
-- Feel free to modify the script for your own use, but leave the copyright notice intact.


return expand("http://www.ergonis.com/products/typinator/") -- for testing in the AppleScript Editor

on expand(theURL) -- parameter: URL
	try
		if length of theURL = 0 then set theURL to (the clipboard as string)
		ignoring case
			if ((characters 1 through 4 of theURL as string) is not "http") then
				error "invalid URL " & theURL & " (must begin with \"http\")"
			else
				set curlCMD to ¬
					"curl --stderr /dev/null \"http://tinyurl.com/api-create.php?url=" & theURL & "\""
				set tinyURL to (do shell script curlCMD)
				return tinyURL
			end if
		end ignoring
	on error (msg)
		return msg
	end try
end expand
