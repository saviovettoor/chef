#
# Cookbook Name:: lamp
# Recipe:: php
#
# Copyright (c) 2018 The Authors, All Rights Reserved.

# Install php
package "php" do
    action :install
end

#Install php necessary packages and restart httpd
package node['lamp']['php_packages'] do
  action :install
  notifies :restart, "service[httpd]"
end
