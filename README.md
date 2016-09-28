# ansible-roles
Ansible roles shared between my different Ansible installations.

To add submodule to a repo:
```git submodule add --force https://github.com/tykling/ansible-roles roles/```

To update all submodules in a repo:
```git submodule foreach git pull origin master```

Make an alias to update all submodules in a repo:
```git config --global alias.updateroles '!git submodule foreach git pull origin master && git submodule foreach git add && git commit -m "update all submodules" && git push'```
