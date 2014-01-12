wget http://yum.baseurl.org/download/2.0/yum-2.0.8-1.src.rpm
rpmbuild --rebuild yum-2.0.8-1.src.rpm
mv /usr/src/redhat/RPMS/noarch/yum-2.0.8-1.noarch.rpm  ./
rpm -ivh yum-2.0.8-1.noarch.rpm
mv /etc/yum.conf /etc/yum.conf.bak
echo '[main]
cachedir=/var/cache/yum
debuglevel=2
logfile=/var/log/yum.log
pkgpolicy=newest
distroverpkg=redhat-release
tolerant=1
exactarch=1

[base]
name=CentOS-$releasever - Base
baseurl=http://vault.centos.org/4.9/os/x86_64/
gpgcheck=1

[updates]
name=Red Hat Linux $releasever - Updates
baseurl=http://vault.centos.org/4.9/updates/x86_64/
gpgcheck=1' > /etc/yum.conf

rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-4

yum update

