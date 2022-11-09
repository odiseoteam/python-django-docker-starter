<h1 align="center">Python Django Docker Starter</h1>

About
-----

This project uses [Django](https://www.djangoproject.com/).

## 🚀&nbsp; Docker installation

### Requirements

To access your project via the configured domain, you need to add it to your /etc/hosts file:

```
127.0.0.1    localhost
```
### Configure the environment

Copy the Docker environment variables and modify at your needs:

```bash
cp .env.docker.dist .env.docker
```

### Build container images

```bash
make build
```

### Startup Containers

```bash
make up
```

Then go to http://localhost/.

### Update Container Configuration

When changing configuration inside of the `docker` folder, the environment must be rebuilt and restarted:

```bash
make down
make build
make up
```

### Trust the local Certificate
Import the generated certificate to use HTTPS.

#### Chrome
Go to Settings > Privacy & Security > Security > Manage certificates > Authorities and import RootCA.crt created in ./docker/nginx/certs/.

#### Windows 10: Chrome, IE11 & Edge
Windows 10 recognizes .crt files, so you can right-click on RootCA.crt > Install to open the import dialog.
Make sure to select "Trusted Root Certification Authorities" and confirm.
You should now get a green lock in Chrome, IE11 and Edge.

#### Windows 10: Firefox
There are two ways to get the CA trusted in Firefox.
The simplest is to make Firefox use the Windows trusted Root CAs by going to about:config, and setting security.enterprise_roots.enabled to true.
The other way is to import the certificate by going to about:preferences#privacy > Certificats > Import > RootCA.pem > Confirm for websites.

### Production environment

Start the containers using the production configuration:

```bash
docker compose \
    -f ./docker-compose.prod.yml \
    -f ./docker-compose.yml \
    --env-file=.env.local --env-file=.env.docker \
    up -d
```

Request the certificate and store it in /etc/letsencrypt:

```bash
docker run -it --rm --name certbot \
	-v "/etc/letsencrypt/:/etc/letsencrypt/" \
	-v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
	-v "/var/www/certbot:/var/www" \
	certbot/certbot certonly --webroot \
	--webroot-path /var/www -d localhost
```

Install the missing ngnix configuration file for ssl:

```bash
wget -O /etc/letsencrypt/options-ssl-nginx.conf \
    https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf
```

Credits
-------------

This repository is maintained by <a href="https://odiseo.io">Odiseo</a>. Want us to help you with this plugin or any Sylius project? Contact us on <a href="mailto:team@odiseo.com.ar">team@odiseo.com.ar</a>.
