# compile all scripts

OSAC=/usr/bin/osacompile

all: rawmail

rawmail: Show\ Raw\ Mail\ Message.scpt

Show\ Raw\ Mail\ Message.scpt : Show\ Raw\ Mail\ Message.applescript
	/usr/bin/osacompile -o "Show Raw Mail Message.scpt" "Show Raw Mail Message.applescript"

clean:
	rm *.scpt
    
