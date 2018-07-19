# Challenges
```
1. Disable and stop iptables, selinux, firewalld
2. Install EPEL Repo, php, mysql, wordpress and wordpress CLI . 
3. Bring up the wordpress.
```

Lets generate cookbook wordpress first
```
wrkstn]#chef generate cookbook wordpress
Generating cookbook wordpress
....
```

Adding cookbook to server
```
wrkstn]# knife cookbook upload wordpress
Uploading wordpress        [0.1.0]
Uploaded 1 cookbook.
```
Add node1 to cookbook wordpress runlist
```
wrkstn]# knife node run_list add node1 wordpress
node1:
  run_list: recipe[wordpress]
```
Applying cookbook to the node
```
node1]#chef-client
.....
```

At the end
<img src="../images/scenario-103a.png">