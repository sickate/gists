# validate pub agains private key
diff -s <(ssh-keygen -y -f ~/.ssh/id_rsa) <(cut -d ' ' -f 1,2 ~/.ssh/id_dsa.pub)

# remote control with paralle
pssh -i -H username@mars -H username@venus -H username@earth 'nodetool status'

# pssh with host profile
pssh -i -h ~/.hosts/elements.txt  'df -h'

# pssh add a line to file
pssh -i -h ~/.hosts/solar.txt "echo alias chklarge=\'grep large /var/log/cassandra/system.log\' >> ~/.bashrc"

# complex single quotes
pssh -i -h ~/.hosts/solar.txt "echo alias chkwe=\"egrep '"'"'WARN|ERROR'"'"' /var/log/cassandra/system.log\" >> ~/.bashrc"

# pscp
pscp -r -h ~/.hosts/new.txt ./bootstrap /tmp/

# pssh with password input
pssh -A -i -h ~/.hosts/solar.txt
