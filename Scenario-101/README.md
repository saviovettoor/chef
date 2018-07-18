1. Create a user demo
2. set pid and password "password@123"


Create a cookbook for manage-user
```
workstn]# chef generate cookbook manage-user
Generating cookbook manage-user
......
```

After cookbook is ready now upload to chefserver
```
workstn]# knife cookbook upload manage-user
Uploading manage-user        [0.1.0]
Uploaded 1 cookbook.
```
Listout the cookbook
```
workstn]# knife cookbook list
manage-user   0.1.0
```
Add our node1 to runlist for this cookbook
```
workstn]# knife node run_list add node1 manage-user
node1:
  run_list: recipe[manage-user]
```
How password is masked?
```
workstn]# openssl passwd -1 "Ifc@1234"
$1$erWfbBFn$kNkEnTjCTByK.hUo0188s.
```

Apply the cookbook to node1
```
node1]#
chef-client
[2018-07-18T16:16:55+05:30] INFO: Forking chef instance to converge...
Starting Chef Client, version 12.22.5
....
```
