
-- from https://apple.stackexchange.com/questions/437970/how-to-stop-com-apple-metadatakmditemwherefroms-attribute-from-being-saved-in-f/437982#comment629961_437982


on adding folder items to theFolder after receiving theFiles
    repeat with aFile in theFiles
        set filePath to quoted form of POSIX path of aFile
        do shell script "xattr -d com.apple.metadata:kMDItemWhereFroms " & filePath
    end repeat
end adding folder items to
