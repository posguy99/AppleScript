#!/usr/bin/osascript

(*
from : https://superuser.com/questions/399899/show-hide-extension-of-a-file-through-os-x-command-line
usage: toggle_hidden_extension.sh file
*)

(*
Test 1 : ./toggle_hidden_extension.sh /Users/boissonnfive/Desktop/file.txt
Test 2 : ./toggle_hidden_extension.sh
Test 3 : ./toggle_hidden_extension.sh 0fdjksl/,3
*)

on run argv
    try
        processArgs(argv)
        toggleHiddenExtension(item 1 of argv)
    on error
        return usage()
    end try

    if result then
        return "Extension hidden for " & POSIX path of (item 1 of argv)
    else
        return "Extension revealed for " & (POSIX path of (item 1 of argv))
    end if

end run


on usage()

    return "usage: toggle_hidden_extension.sh file"

end usage

on processArgs(myArgs)

    set item 1 of myArgs to POSIX file (first item of myArgs) as alias

end processArgs

on toggleHiddenExtension(myFile)

    tell application "Finder" to set extension hidden of myFile to not (extension hidden of myFile)

end toggleHiddenExtension
