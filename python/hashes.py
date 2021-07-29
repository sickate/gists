import hashlib

def get_md5(input):
    return hashlib.md5(input.encode(encoding='UTF-8')).hexdigest()
