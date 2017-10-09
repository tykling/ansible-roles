Certgrinder client role
========================

The following settings are needed in host_vars or group_vars for the certgrinder client:

    certgrinder_ssh_server: "certgrinder.servers.example.org"
    certgrinder_redirect_url: "https://certgrinder.example.org"
    certgrinder_admin_email: "admin@example.com"
    certgrinder_hostname_sets:
      - "example.com,www.example.com"
      - "example.org,www.example.org"
    certgrinder_ssh_server_pubkey: "AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBM7V020oJtyKZk3CeC+tDs+ml/ieo/yOPFxtEmz8HsKWACaAKKk9Lb55L6ZQIRQDpPy8V9Y3/xD8kvTRKuzn93Y="

Optionally certgrinder can restart one or more local services after a cert is renewed:

    certgrinder_post_renew_hooks:
      - "/usr/sbin/service -R"

Remove certgrinder_post_renew_hooks if nothing needs to be done after a renew.

If non-root users need to read the certificates they have to be a member of the certgrinder group. Specify a list of users or remove it if not needed.

    certgrinder_cert_users:
      - "ircd"

If source ip selection is important set certgrinder_bind_ip to something:

    certgrinder_bind_ip: "192.0.2.34"

Running certgrinder from Ansible
---------------------------------
To run certgrinder from an ansible task in another role include the run_certgrinder.yml file from the certgrinder_run role like so:

    - name: "Run certgrinder"
      include_role:
        name: "certgrinder_run"
        tasks_from: "run_certgrinder"

This should come after the certgrinder_client role (which configures certgrinder and should probably be included as a role dependency).


Challenges
-----------
Something to handle the challenge HTTP redirect is also needed. nginx_server role can be used with something like the following nginx_locationslash:

    nginx_locationslash:
      location /.well-known/acme-challenge/ {
            return 301 {{ certgrinder_redirect_url }}$request_uri;
      }
      location / {
            return 301 https://example.com;
      }

... or any other way. Or just redirect it in the firewall.

