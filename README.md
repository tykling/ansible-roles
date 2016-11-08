# ansible-roles
Ansible roles shared between my different Ansible installations.

To add this as a submodule to an ansible repo:
```git submodule add --force https://github.com/tykling/ansible-roles roles/```

For reference: Make an alias to update all submodules in a repo:
```git config --global alias.updatesub '!git submodule update --init --recursive && git submodule foreach git pull origin master && git submodule foreach "cd .. && git add \$path" && git commit -m "update all submodules" && git push; git submodule deinit .'```

