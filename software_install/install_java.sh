# download java
eudo cp ../packages/jdk-8u162-linux-x64.tar.gz /opt/
cd /opt
sudo tar xzf jdk-8u162-linux-x64.tar.gz

# set java
sudo alternatives --install /usr/bin/java java /opt/jdk1.8.0_162/bin/java 2
sudo alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_162/bin/jar 2
sudo alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_162/bin/javac 2

sudo alternatives --config java

sudo alternatives --set jar /opt/jdk1.8.0_162/bin/jar
sudo alternatives --set javac /opt/jdk1.8.0_162/bin/javac

# set java env
export JAVA_HOME=/opt/jdk1.8.0_162
export JRE_HOME=/opt/jdk1.8.0_162/jre
export PATH=$PATH:/opt/jdk1.8.0_162/bin:/opt/jdk1.8.0_162/jre/bin

sudo /bin/sh -c 'echo "export JAVA_HOME=/opt/jdk1.8.0_162" >> /etc/bashrc'
sudo /bin/sh -c 'echo "export JRE_HOME=/opt/jdk1.8.0_162/jre" >> /etc/bashrc'
sudo /bin/sh -c 'echo "export PATH=$PATH:/opt/jdk1.8.0_162/bin:/opt/jdk1.8.0_162/jre/bin" >> /etc/bashrc'


