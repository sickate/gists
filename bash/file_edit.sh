# find and replace
grep -q -F '[Service]' /usr/lib/systemd/system/elasticsearch.service || echo 'include "/configs/projectname.conf"' >> foo.bar

sudo grep -q -F 'LimitMEMLOCK=infinity' /usr/lib/systemd/system/elasticsearch.service || sudo awk '/Service/ { print; print "LimitMEMLOCK=infinity"; next }1' /usr/lib/systemd/system/elasticsearch.service > /tmp/elasticsearch.service && sudo cp /tmp/elasticsearch.service /usr/lib/systemd/system/elasticsearch.service

# sudo echo issue fix
# -a means append
echo "export JAVA_HOME=/etc/alternatives/java_sdk" |sudo tee -a ~/.bashrc

export HBASE_HOME=/opt/hbase/current

# remove executable for files
find . -type f -exec chmod -x {} \;

# CUT
cut -d ' ' -f 1 
# Press Ctrl-v + Tab
cut -f2 -d'   ' infile
# or write it like this:
cut -f2 -d$'\t' infile

# SORT
sort -u | head -105 | awk 'BEGIN{a="";}NR>3{a=a"|"$1;}END{gsub(/[\[\]]/,"",a);print substr(a,2,100000);}' | xargs -i grep -E {} LOGFILE | wc -l

# to lower
cat data/dts/2018-04-03/* | cut -d '|' -f 1,2,3,4,5,6,7 | sort -u | awk '!arr[tolower($1)]++' | uniq > data/dts/all_id.txt

# cp with whole attributes
cp -ax / /mnt

# rsync
# -a  : all files, with permissions, etc..
# -v  : verbose, mention files
# -x  : stay on one file system
# -H  : preserve hard links (not included with -a)
# -A  : preserve ACLs/permissions (not included with -a)
# -X  : preserve extended attributes (not included with -a)
rsync -avxHAX --progress / /new-disk/

# count
.. | paste -sd+ - | bc

# less gz file: 
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# check long gc in cassandra
zgrep 'GC in [0-9][0-9][0-9][0-9]' /var/log/cassandra/system.log.*.zip | awk '{print $4}' | sort | uniq -c | awk '{print $2" "$1}' | tail

# sed replace
ls ./* | sed 's/-FIN//'| xargs rm


# egrep output pattern
egrep -oh '(\d{1,3}\.){3}\d{1,3}' log/large.log


# AWK
# condition: $10 > 309
# action print $10
awk -F' ' '$10>309 {print $10}' test.log
# condition: $10 > 309
# action: sum $10
# END action: print $10
awk -F' ' '{sum += $10} END {print sum}' test.log


# SED
# -i means (IN GNU) inplace editing
sed -i -e 's/abc/XYZ/g' /tmp/file.txt
# delete 5th line
sed -i 5d test.log
# replace
sed s/cat/dog/g file.txt
# print 2th line
sed -n 2p file.txt
# insert blank line in between every line
sed G file.txt
# delete matching line
sed /cat/d
# delete matching line, save original file as .bak
sed -i.bak '/^HERE IT IS/d' <file>
# insert line on line 7
sed 'i7 myline' file.txt

