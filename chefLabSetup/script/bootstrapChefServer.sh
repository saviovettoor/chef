#!/usr/bin/env bash

wget -P /tmp https://packages.chef.io/files/stable/chef-server/12.4.1/ubuntu/14.04/chef-server-core_12.4.1-1_amd64.deb > /dev/null

dpkg -i /tmp/chef-server-core_12.4.1-1_amd64.deb

chef-server-ctl reconfigure
until (curl -D - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
while (curl http://localhost:8000/_status) | grep "fail"; do sleep 15s; done

#Creating chefadmin user who's password is insecurepassword.
chef-server-ctl user-create chefadmin Chef Admin admin@4thcoffee.com insecurepassword --filename /opt/chefadmin.pem
chef-server-ctl org-create devops "DevOps, Inc." --association_user chefadmin --filename /opt/devops-validator.pem

#Use Chef management console to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license
