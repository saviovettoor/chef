#
# Cookbook Name:: manage-user
# Recipe:: default
#
# Copyright 2018, Savio Mathew
#
# All rights reserved - Do Not Redistribute

#Adding new user demo and setting password
user node["scenario-101"]["username"] do
  comment "demo User with admin privilage"
  supports :manage_home => true
  uid 10011
  gid "users"
  home "/home/#{node["scenario-101"]["username"]}"
  shell "/bin/bash"
  password "#{node['scenario-101']['user_password']}"
end
