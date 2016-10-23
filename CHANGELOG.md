# Change Log
This is the changelog for tykling/ansible-roles. The latest version of this file can always be found [on Github](https://github.com/tykling/ansible-roles/blob/master/CHANGELOG.md)

All notable changes to these roles will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/).


## [v0.0.3][23-oct-2016]
### Changed
- Make jailhost flavour name and ssh key configurable. Make the following changes:
    - Add something like this to the jailhost host_vars:
        ansible_authorized_keys: |
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYAgVCz9Je9n2xHPcRRdThZIfwhOCr1Kp6ZfAbOLJEZ ansible@ansible-control.censurfridns.dk
    - Optionally add a different ezjail_flavourname to the jail host host_vars (if the default name "tykbasic" is not appropriate)


## [v0.0.2][20-oct-2016]
### Changed
- Moved library into this repo. Make the following changes:
    - Remove library= line from ansible.cfg
    - git rm library/
    - git updatesub


## [v0.0.1][19-oct-2016]
### Changed
- Started this changelog
- Moved playbooks into this repo
- Merged playbooks into one file with tags instead of multiple files
- Set become=yes in playbook to save having it in all the tasks
- Add a mechanism to create extra nginx config include files like ACLs

