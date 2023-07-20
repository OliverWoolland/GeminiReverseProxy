# GeminiReverseProxy #

A containerised reverse proxy for the Gemini / MCFE server.

The proxy is implemented using the [Swag](https://docs.linuxserver.io/general/swag) container by linuxserver.io.

## Setup ##

A template environment is provided, this should be copied and populated.

```console
foo@bar:~$ cp .env.template .env # n.b. the . is essential!
foo@bar:~$ nano .env # for example
```

Two variables are needed:

`URL` the URL you wish to get certificates for 
`EMAIL` the email address registering for the certificates

## Configuration ##

To add subdomains, add an extra file to the proxy-confs configuration directory. An example:

```diff
    volumes:
      - ${PWD}/data/swag/swag_config_store:/config
+     - ${PWD}/data/swag/config/proxy-confs/example.subdomain.conf:/config/nginx/proxy-confs/example.subdomain.conf
```

The contents of the subdomain file should be similar to the below:

```diff
server {
    listen 443 ssl;
    listen [::]:443 ssl;

+   server_name example.*;

    include /config/nginx/ssl.conf;

    client_max_body_size 0;

    location / {
        include /config/nginx/proxy.conf;
        include /config/nginx/resolver.conf;
+       set $upstream_app example;
        set $upstream_port 80;
        set $upstream_proto http;
        proxy_pass $upstream_proto://$upstream_app:$upstream_port;

    }
}
```

## Launch ##

To launch the service run docker-compose:

```console
foo@bar:~$ docker-compose up
```

If you are happy and there are no errors, launch the service in a detached state:

```console
foo@bar:~$ docker-compose up --detach
```
