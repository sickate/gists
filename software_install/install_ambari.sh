mkdir -p ~/packages
cd !$
wget ftp://shanghai/pub/apache-ambari-2.7.1-src.tar.gz

tar xfvz apache-ambari-2.7.1-src.tar.gz
cd apache-ambari-2.7.1-src
mvn versions:set -DnewVersion=2.7.1.0.0

pushd ambari-metrics
mvn versions:set -DnewVersion=2.7.1.0.0
popd

mvn -B clean install rpm:rpm -DnewVersion=2.7.1.0.0 -DbuildNumber=90430db08a5f543a97d97918cf5f711f2786ad8a -DskipTests -Dpython.ver="python >= 2.6"

