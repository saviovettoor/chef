#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2018, Savio Mathew
#
# All rights reserved - Do Not Redistribute
#
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

# Install Necessary Packages
package node['lamp']['yum_packages'] do
  action :install
end
