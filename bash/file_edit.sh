# find and replace
grep -q -F '[Service]' /usr/lib/systemd/system/elasticsearch.service || echo 'include "/configs/projectname.conf"' >> foo.bar

sudo grep -q -F 'LimitMEMLOCK=infinity' /usr/lib/systemd/system/elasticsearch.service || sudo awk '/Service/ { print; print "LimitMEMLOCK=infinity"; next }1' /usr/lib/systemd/system/elasticsearch.service > /tmp/elasticsearch.service && sudo cp /tmp/elasticsearch.service /usr/lib/systemd/system/elasticsearch.service

# sudo echo issue fix
# -a means append
echo "bla bla" |sudo tee -a /etc/some_wheel_file

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
