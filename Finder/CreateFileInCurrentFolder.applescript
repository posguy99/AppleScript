
-- From http://hints.macworld.com/article.php?story=20050219134457298

try
  tell application "Finder" to set the this_folder ¬
   to (folder of the front window) as alias
on error -- no open folder windows
  set the this_folder to path to desktop folder as alias
end try

set thefilename to text returned of (display dialog ¬
 "Create file named:" default answer "filename.txt")
set thefullpath to POSIX path of this_folder & thefilename
do shell script "touch \"" & thefullpath & "\""
