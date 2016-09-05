
-- get path including script name
set thePath to POSIX path of (path to me as text)
display dialog "The path to me is: " & thePath

-- get path without script name
set thePath to POSIX path of ((path to me as text) & ":")
display dialog "The path to me is: " & thePath
