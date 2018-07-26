Challenge:
```
1. Bringup a lamp setup
2. Use of berkshelf, data_bag(for store passwpord)
```

```
wrkstn]#chef generate cookbook lamp
Generating cookbook lamp
- Ensuring correct cookbook file content
- Ensuring delivery configuration
- Ensuring correct delivery build cookbook content
...
```

Now create the recipes inside cookbook lamp
```
wrkstn]#chef generate recipe apache
wrkstn]#chef generate recipe mysql
wrkstn]#chef generate recipe php
```

```
wrkstn/lamp]#ll recipes/
-rw-r--r--. 1 root root 100 Jul 26 10:36 apache.rb
-rw-r--r--. 1 root root 130 Jul 26 10:30 default.rb
-rw-r--r--. 1 root root  99 Jul 26 10:36 mysql.rb
-rw-r--r--. 1 root root  97 Jul 26 10:36 php.rb
```

Uploading cookbook from workstation to server
```
wrkstn]#knife cookbook --force upload lamp
Uploading lamp           [0.1.0]
Uploaded 1 cookbook.
```

Adding node1 to runlist
```
wrkstn]#knife node run_list add node1 lamp
node1:
  run_list:
    recipe[lamp]
```

Apllying lamp on node1
```
]#chef-client
```

NOTE: Make Sure Berkshelf dependency manager for Chef cookbooks is installed and update after ading "depends mysql" in metadata.rb
