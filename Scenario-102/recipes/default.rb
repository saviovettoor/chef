#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright (c) 2018 Savio Mathew, All Rights Reserved.

# Stop the firewall
service "iptables" do
  action [:disable, :stop]
end

#Stop iptables6
service "ip6tables" do
  action [:disable, :stop]
end

#Stop firewalld
service "firewalld" do
  action [:disable, :stop]
end

#Disable SELinux
#selinux_state "SELinux Disabled" do
#  action :disabled
#end

#Disable SELinux
execute "Disable SELINUX" do
  command "sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config"
end

# Install Httpd service and start it
httpd_service 'default' do
  action [:create, :start]
end

#Replace the default httpd welcome page with custom page
template "/usr/share/httpd/noindex/index.html" do
  source "httpd_welcomepage_replace.erb"
  mode 0600
  owner "root"
  group "root"
end

# reload httpd after page change 
httpd_service 'default' do
  action [:reload]
end