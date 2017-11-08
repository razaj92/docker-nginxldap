# docker-ldapnginx

Alpine container running nginx with the nginx-auth-ldap module

## Usage
``docker run -it --rm -p 8080:80 -e LDAP_URL='ldap://LDAP_SERVER/DC=test,DC=local?sAMAccountName?sub?(objectClass=user)' -e LDAP_BINDDN='USER' -e LDAP_BINDPASSWD='PASSWORD' -e LDAP_GROUP='CN=test,OU=groups,DC=test,DC=local' -e PROXY_PASS='https://www.example.co.uk'  razaj92/nginx-ldap:latest``
