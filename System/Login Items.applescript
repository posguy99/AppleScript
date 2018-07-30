-- requires 10.13 or higher
use AppleScript version "2.4"
use scripting additions
use framework "Foundation"
#  classes, constants, and enums used
property NSPropertyListMutableContainersAndLeaves : a reference to 2
property NSData : a reference to current application's NSData
property NSPropertyListSerialization : a reference to current application's NSPropertyListSerialization
property NSArray : a reference to current application's NSArray
property NSURL : a reference to current application's NSURL
property NSString : a reference to current application's NSString
-- check we're on 10.13 or higher
set v to AppleScript's version as number
if v is greater than 2.6 then

    set logins to {}
    -- get user name and home path
    set whoami to current application's NSUserName()
    set whereami to current application's NSHomeDirectoryForUser(whoami) as text

    -- look for the .btm file or throw an error
    set posixPath to whereami & "/Library/Application Support/com.apple.backgroundtaskmanagementagent/backgrounditems.btm"
    set {theData, theError} to NSData's dataWithContentsOfFile:posixPath options:0 |error|:(reference)
    if theData = missing value then error theError's localizedDescription() as text

    -- deserialize the property list or throw an error
    set {newValue, theError} to NSPropertyListSerialization's propertyListWithData:theData options:NSPropertyListMutableContainersAndLeaves format:(missing value) |error|:(reference)
    if newValue = missing value then error theError's localizedDescription() as text

    -- parse the list
    set smg to newValue's objectForKey:"$objects"
    set NSURLEnumList to NSArray's arrayWithObject:(NSString's stringWithString:"NSURLBookmarkAllPropertiesKey")
    repeat with s in smg
        try
            if (s's isKindOfClass:(NSData's class)) then
                set thgs to s
            else
                set thgs to (s's objectForKey:"NS.data")
                if thgs is not missing value then
                    set prps to (NSURL's resourceValuesForKeys:NSURLEnumList fromBookmarkData:thgs)
                    if prps is not missing value then
                        set li to (prps's valueForKey:(NSURLEnumList's item 1)) as record
                        set end of logins to {name:li's NSURLNameKey, location:li's _NSURLPathKey}
                    end if
                end if
            end if
        end try
    end repeat

    -- return the results, hopefully a list of login item names and paths
    logins
else
    error "This script requires 10.13 or higher"
end if
