# convert string to binary(utf8)
arr = "test string".unpack("U*") # outputs an array

# convert integer to string with padding 0s
bin = arr.map {|s|'%08b' % s}.join("")

# convert binary back to str
bin.scan(/.{8}/).map{|s|s.to_i(2)}.pack("U*")


