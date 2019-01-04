# network
dstat -nt

# process

# show context switch numbers
grep ctxt /proc/$pid/status

# update above number twice a second.
watch -n.5 grep ctxt /proc/$pid/status
