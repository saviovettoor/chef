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
