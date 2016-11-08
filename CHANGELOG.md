# Change Log
This is the changelog for tykling/ansible-roles. The latest version of this file can always be found [on Github](https://github.com/tykling/ansible-roles/blob/master/CHANGELOG.md)

All notable changes to these roles will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/).

## [v0.0.12][8-nov-2016]
### Changed
- nginx_ssh_server: Rename role to people_server, and include all the nginx stuff from nginx_https_server role

## [v0.0.11][3-nov-2016]
### Added
- freebsd: Create /etc/motd

## [v0.0.10][2-nov-2016]
### Changed
- jail_host: Add dummy placeholder file one more place because git doesn't do empty folders
- jail_host: Remove dummy placeholder files after copying flavour


## [v0.0.9][2-nov-2016]
### Changed
- jail_host: renamed ansible_authorized_keys_file to ezjail_flavour_ansible_authorized_keys_file to clarify its purpose


## [v0.0.8][2-nov-2016]
### Added
- freebsd role to create users and install basic packages
- get package list from {{ packages }} variable

### Changed
- playbook includes freebsd role for all roles
- role dependencies on poudriere_client removed, now included in freebsd role


## [v0.0.7][29-oct-2016]
### Changed
- nginx_https_server: Added default true for letsencrypt
- nginx_https_server: Add default false for default_vhost

## [v0.0.6][27-oct-2016]
### Added
- log rotation for nginx_http_server and nginx_https_server roles, using freebsds newsyslog


## [v0.0.5][26-oct-2016]
### Added
- nginx_https_server role got htpasswd support
### Changed
- nginx_https_server and nginx_http_server ipv6 listen statements are now always default vhost for that ip


## [v0.0.4][23-oct-2016]
### Added
- Add user creation to jail_host role. Make the following changes:
  - Add a dict to host_vars like this:
    users:
      foo:
      comment: "foo user"
      key: "ssh-rsa ..............."
- Add package installation to jail host


## [v0.0.3][23-oct-2016]
### Changed
- Make jailhost flavour name and ansible ssh authorized_key configurable. Make the following changes:
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

