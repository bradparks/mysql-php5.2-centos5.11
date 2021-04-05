Based off of:
https://github.com/bradparks/Docker-PHP-5.2-oci-mysql-sqlite-postgres-with-centos/blob/master/Dockerfile

# Getting started
buildit.sh - builds the docker image
runit.sh - runs the docker image

MySql server isn't setup, but is installed, and ready to run
login to server

You can start the MySQL daemon with:
cd /usr ; /usr/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl
cd mysql-test ; perl mysql-test-run.pl

Secure your installation by running:
$ /usr/bin/mysql_secure_installation

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:
/usr/bin/mysqladmin -u root password 'new-password'
/usr/bin/mysqladmin -u root -h 46b3dfa0caaf password 'new-password'
