import urllib2
BUFFER_SIZE = 256*1023
url = 'http://downloads.sourceforge.net/project/pydev/pydev/PyDev%202.5.0/PyDev%202.5.0.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpydev%2Ffiles%2F&ts=1338118912&use_mirror=nchc'
res = urllib2.urlopen(url)
with open('PyDev.zip', 'wb') as f:
	while True:
		chunk = res.read(BUFFER_SIZE)
		if(not chunk):
			break		
		f.write(chunk)
		print len(chunk)