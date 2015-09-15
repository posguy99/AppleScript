set theData to (the clipboard as text)
set theResult to do shell script "echo " & quoted form of theData & ¬
	" | sed -e 's/ //g'"
set the clipboard to theResult







on run (input)

	set theResult to do shell script "echo " & quoted form of input & ¬
		" | sed -e 's/ //g'"
	set the clipboard to theResult
	do shell script "pbpaste"

end run
