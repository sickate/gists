toHex = lambda x:"".join([hex(ord(c))[2:].zfill(2) for c in x])

toHex(a)
# '6633333539643534343137383639376236393137353864363461383730623937'

int(a, 16)
# 323280785722972422352142175852657314711

hex(_)
# '0xf3359d544178697b691758d64a870b97'
