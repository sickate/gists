# update ulimits for es to unlock
sudo /bin/sh -c 'echo # allow user elasticsearch mlockall >> /etc/security/limits.conf'
sudo /bin/sh -c 'echo "root    soft    memlock unlimited" >> /etc/security/limits.conf'
sudo /bin/sh -c 'echo "root    hard    memlock unlimited" >> /etc/security/limits.conf'
sudo /bin/sh -c 'echo "elasticsearch    soft    memlock unlimited" >> /etc/security/limits.conf'
sudo /bin/sh -c 'echo "elasticsearch    hard    memlock unlimited" >> /etc/security/limits.conf'

# update nproc in 20-nproc
sudo /bin/sh -c 'echo "elasticsearch	hard	nproc	unlimited" >> /etc/security/limits.d/20-nproc.conf'
sudo /bin/sh -c 'echo "elasticsearch	soft	nproc	unlimited" >> /etc/security/limits.d/20-nproc.conf'

# update systemd config
sudo /bin/sh -c 'echo "DefaultLimitNOFILE=65536" >> /etc/systemd/system.conf'
sudo /bin/sh -c 'echo "DefaultLimitNPROC=32000" >> /etc/systemd/system.conf'
sudo /bin/sh -c 'echo "DefaultLimitMEMLOCK=infinity" >> /etc/systemd/system.conf'
