Certgrinder client role
========================

The following settings are needed in host_ or group_vars for the certgrinder client:

    certgrinder_ssh_server: "certgrinder.servers.example.org"
    certgrinder_redirect_url: "https://certgrinder.example.org"
    certgrinder_admin_email: "admin@example.com"
    certgrinder_hostname_sets:
      - "example.com,www.example.com"
      - "example.org,www.example.org"

Optionally certgrinder can restart one or more local services after a cert is renewed:

    certgrinder_post_renew_hooks:
      - "/usr/sbin/service -R"

Remove certgrinder_post_renew_hooks if nothing needs to be done after a renew.


Running certgrinder from Ansible
---------------------------------
To run certgrinder from an ansible task in another role include the run_certgrinder.yml task like so:

    - name: "Run certgrinder"
      include_role:
        name: "certgrinder_client"
        tasks_from: "run_certgrinder"

This should come after the certgrinder_client role which should probably be included as a role dependency.


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

