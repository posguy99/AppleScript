-- Simple example of using the SerialPort scripting commands.
--
--   Send an On command for House Code 'C', Device '12' to 
--   the X-10 CP290 Interface.
--
--   Art Coughlin 	2/2004
-- 
-- Note:  you may need to add a delay between some commands to allow
--          enough time for the data to be read/written (especially at 
--          slower bps rates).

property thePorts : {} --Attached Serial Ports

-- List the Serial Ports & select one from list

-- set thePorts to serialport list
set dev to "/dev/cu.NoZAP-PL2303-001014FD"

-- Open the selected serial port port at 600 bps.  Since the open command is using
-- default parms (except for bps rate), both open commands below are equivalent.

-- If opened, create a command string for the CP290 Interface and write it out the
-- serial port.  (See CP290 programming manual for commands).

-- Check to see if CP290 responded.
-- Read in 19 byte acknowledgement from CP290.  Byte 7 (status) is set to 1 if ok.

-- set portRef to serialport open dev bps rate 600
set portRef to «event SPA_oSPA» dev given «class SPbr»:600, «class SPdb»:8, «class SPpa»:0, «class SPsb»:1, «class SPhs»:0
if portRef is equal to -1 then
	display dialog " could not open port "
else
	-- Create command string  (CP290 command requires 16 sync bytes)
	set CP290cmd to MakeString({255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 1, 2, 32, 0, 64, 98})
	-- Write the command to the CP290
	«event SPA_wSPA» CP290cmd given «class SPpt»:portRef
	delay 3 -- CP290 is slow.  Give it a chance to respond. 
	set x to «event SPA_aSPA» portRef --could use this in a loop instead of delay 3
	set xs to x as string
	-- display dialog "Bytes available = " & xs
	if x is greater than 0 then
		set reply to «event SPA_rSPA» portRef
		set x to length of reply
		set xs to x as string
		-- display dialog "Bytes read = " & xs
		set x to ASCII number (character 7 of reply)
		set xs to x as string
		-- display dialog "Byte 7 = " & xs
	end if
	«event SPA_cSPA» portRef
end if

-- This function takes a list of byte values and 
-- converts them into a string of characters

on MakeString(theBytes)
	set thestr to ""
	repeat with i from 1 to length of theBytes
		set thestr to thestr & (ASCII character (item i of theBytes))
	end repeat
	return thestr
end MakeString
