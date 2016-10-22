# Change Log
This is the changelog for tykling/ansible-roles. The latest version of this file can always be found [on Github](https://github.com/tykling/ansible-roles/blob/master/CHANGELOG.md)

All notable changes to these roles will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/).

## [v0.0.2][20-oct-2016]
### Changed
- Moved library into this repo, make the following changes:
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

