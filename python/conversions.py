toHex = lambda x:"".join([hex(ord(c))[2:].zfill(2) for c in x])
oooo

toHex(a)
# '6633333539643534343137383639376236393137353864363461383730623937'

int(a, 16)
# 323280785722972422352142175852657314711

hex(_)
# '0xf3359d544178697b691758d64a870b97'


import base64
base64.b64decode('YmluYXJ5AHN0cmluZw==')
base64.b64encode('binary\x00string')


from ast import literal_eval
repl = x.replace("'", "\\x27")
result = literal_eval("b'{}'".format(repl)).decode('utf-8')


import time
import datetime
time.mktime(datetime.datetime.strptime("2011-01-02", "%Y-%m-%d").timetuple())


# String padding 
n = '4'
print(n.zfill(3))
# 004

# And for numbers:
n = 4
print('%03d' % n)
>> 004
