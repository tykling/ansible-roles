Certgrinder client role
========================

The following settings are needed:

certgrinder_ssh_server: "certgrinder.servers.example.org"
certgrinder_http_redirect: "https://certgrinder.example.org"
certgrinder_hostname_sets:
 - "example.com,www.example.com"
 - "example.org,www.example.org"

Something to handle the HTTP redirect is also needed. nginx_server role can be used with something like the following nginx_locationslash:

nginx_locationslash:
  location /.well-known/acme-challenge/ {
        return 301 {{ certgrinder_http_redirect }}$request_uri;
  }
  location / {
        return 301 https://example.com;
  }

... or any other way. Or just redirect it in the firewall.

