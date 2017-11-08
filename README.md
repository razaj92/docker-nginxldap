# docker-ldapnginx

Alpine container running nginx with the nginx-auth-ldap module

## Usage
``docker run -it --rm -p 8080:80 -v `pwd`/bin/nginx.conf:/etc/nginx/nginx.conf razaj92/nginx-ldap:latest``
