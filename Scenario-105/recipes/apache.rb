#
# Cookbook Name:: lamp
# Recipe:: apache
#
# Copyright (c) 2018 The Authors, All Rights Reserved.

# Install HTTPD
package "httpd" do
  action :install
end

# Enable and Starting httpd service
service "httpd" do
  action [:enable, :start]
  supports :reload => true
end
