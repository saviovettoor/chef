CREATE DATABASE wordpress;
CREATE USER wordpressuser@localhost IDENTIFIED BY 'mysqlDBpassword';
GRANT ALL PRIVILEGES ON wordpress.* TO root@'%' IDENTIFIED BY 'mysqlDBpassword';
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@'%' IDENTIFIED BY 'mysqlDBpassword';
FLUSH PRIVILEGES;
