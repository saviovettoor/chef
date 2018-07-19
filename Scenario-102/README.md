# Challenge

```
1. Disable and stop iptables, selinux, firewalld
2. Install httpd
3. Replace the default httpd welcome page with custom page.
```

Lets generate cookbook httpd first
```
wrkstn]#knife cookbook site install httpd
Generating cookbook httpd
....
```

Adding cookbook to server
```
wrkstn]# knife cookbook upload httpd
Uploading httpd        [0.1.0]
Uploaded 1 cookbook.
```
Add node1 to cookbook httpd runlist
```
wrkstn]# knife node run_list add node1 httpd
node1:
  run_list: recipe[httpd]
```
Applying cookbook to the node
```
node1]#chef-client
.....
```