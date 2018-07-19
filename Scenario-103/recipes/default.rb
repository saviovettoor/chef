#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright (c) 2018 Savi Mathew, All Rights Reserved.
# Disable and Stop the firewall

# Stop the firewall
service "iptables" do
  action [:disable, :stop]
end

#Stop firewall
service "iptables" do
  action [:disable, :stop]
end

# Disable and Stop the firewall6
service "ip6tables" do
  action [:disable, :stop]
end

#Disable SELinux
execute "Disable SELINUX" do
  command "sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config"
end

#Install EPEL Repo
execute "Install EPEL Repo for YUM dependency management" do
  command "yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
  not_if { File.exists?("/etc/yum.repos.d/epel.repo") }
end

#yum update
execute "Yum Update" do
  command "yum -y update"
end

#Install necessary PHP packages
package node['wordpress']['php_packages'] do
  action :install
end

# Install Necessary Packages
package node['wordpress']['yum_packages'] do
  action :install
end

# Copy the create_wordpress_db.sql file to the machine
template "#{node['wordpress']['installation_directory']}/create_wordpress_db.sql" do
        source "create_wordpress_db.sql"
        mode '0644'
        owner 'root'
        group 'root'
end

# Connect to the DB and create the database, wordpressuser and grant privileges
bash "Create the wordpress datbase in MySQL Server" do
  user "root"
  code <<-EOH
	mysql -uroot < #{node['wordpress']['installation_directory']}/create_wordpress_db.sql
	touch /tmp/.database_creation_successful
	#rm -rf #{node['wordpress']['installation_directory']}/create_wordpress_db.sql	
  EOH
  not_if { ::File.exist?("/tmp/.database_creation_successful") }
end

# Install HTTPD
package "httpd" do
  action :install
end

# Get the latest wordpress tar
bash "Get the latest wordpress tar and extract it" do
  user "root"
  code <<-EOS
	cd /tmp
	wget http://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz --strip-components=1 -C #{node['wordpress']['root_directory']}/
	mkdir -p #{node['wordpress']['root_directory']}/wp-content/uploads
	sudo chown -R apache:apache #{node['wordpress']['root_directory']}/*
  EOS
  not_if { ::File.exist?("/var/www/html/wp-config.php") }
end

# Configure wordpress CLI
bash "Configure Wordpress CLI for command line access" do
  user "root"
  code <<-EOS
	cd /tmp
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
   EOS
   not_if { ::File.exist?("/usr/local/bin/wp") }
end

# Configure Wordpress
bash "Configure Wordpress" do
  user "root"
  code <<-EOS
	cd #{node['wordpress']['root_directory']}/
	cp wp-config-sample.php wp-config.php
	sed -i 's/database_name_here/wordpress/g' wp-config.php
	sed -i 's/username_here/wordpressuser/g' wp-config.php
	sed -i 's/password_here/#{node['wordpress']['mysql_db_password']}/g' wp-config.php
  EOS
  not_if { ::File.exist?("/var/www/html/wp-config.php") }
end

# Enable and Starting httpd service
service "httpd" do
  action [:enable, :start]
  supports :reload => true
end

# Initialize the website
bash "Initialize the website using wordpress CLI" do
  user "root"
  code <<-EOS
	cd #{node['wordpress']['root_directory']}/
	wp core install --url="#{node['wordpress']['website_url']}" --title="My Sample wordpress on Chef" --admin_user="admin" --admin_password="#{node['wordpress']['wordpress_admin_password']}" --admin_email="savifrnds@gmail.com"
	touch /tmp/.wordpress_initialization_successful
   EOS
   not_if { ::File.exist?("/tmp/.wordpress_initialization_successful") }
end