
# dr drang appleScript handler for python
# http://www.leancrew.com/all-this/2013/03/combining-python-and-applescript/

from applescript import asrun, asquote

subject = 'A new email'

body = '''This is the body of my "email."
I hope it comes out right.

Regards,
Test User
'''
ascript = '''
tell application "Mail"
  activate
  make new outgoing message with properties {{visible:true, subject:{0}, content:{1}}}
end tell
'''.format(asquote(subject), asquote(body))

print(ascript)
asrun(ascript)
