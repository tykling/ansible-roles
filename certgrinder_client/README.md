Ansible variables for the certgrinder_client role. Some of these have defaults, others do not.

    {{ certgrinder_user }} = the unix username to use for certgrinder
    {{ certgrinder_post_renew_hooks }} = the list of commands to run after renewing a cert
    {{ certgrinder_ssh_server }} = the hostname of the certgrinderd server, if using ssh
    {{ certgrinder_ssh_server_pubkey }} = the certgrinderd server SSH pubkey, if using ssh
    {{ certgrinder_cert_users }} = the list of usernames to add to certgrinder unix group
    {{ certgrinder_syslog_socket }} = the syslog socket to log to
    {{ certgrinder_hostname_sets }} = the list of hostname sets to get certificates for
    {{ certgrinder_certgrinderd_command }} = the command to reach the certgrinderd server

