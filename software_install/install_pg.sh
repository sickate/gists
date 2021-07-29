
#!/bin/bash

# sudo yum install postgresql11 postgresql11-server postgresql11-contrib postgresql11-libs postgresql11-plpython3
sudo yum install postgresql12 postgresql12-server postgresql12-contrib postgresql12-libs postgresql12-plpython3

# 1. Install a package with repository for your system:
# On CentOS, install package centos-release-scl available in CentOS repository:
sudo yum install centos-release-scl

# On RHEL, enable RHSCL repository for you system:
sudo yum-config-manager --enable rhel-server-rhscl-7-rpms

# 2. Install the collection:
sudo yum install llvm-toolset-7.0

# 3. Start using software collections:
scl enable llvm-toolset-7.0 
sudo yum install postgresql12-devel


# Config
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl start postgresql-12
sudo systemctl enable postgresql-12

sudo -i -u postgres
sudo -u postgres psql
sudo -u postgres createuser --interactive

sudo adduser tzhu
sudo -u postgres createdb stock
\\ ALTER USER postgres WITH PASSWORD 'NewPassword';
GRANT all Privileges ON ALL TABLES IN SCHEMA public  TO tzhu;
alter user tzhu createdb;
