#!/usr/bin/env bash

wget -P /tmp https://packages.chef.io/files/stable/chef-server/12.4.1/ubuntu/14.04/chef-server-core_12.4.1-1_amd64.deb > /dev/null

dpkg -i /tmp/chef-server-core_12.4.1-1_amd64.deb