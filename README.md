# Debian-dockersphinx
Docker debian based image for [Sphinx search engine](http://sphinxsearch.com/docs/sphinx3.html) ver.3.4.1

## Usage example

You can use this docker-compose.yml file to include sphinxsearch engine into your project

```yaml
services:
  sphinxsearch:
    image: sphinxsearch:${TAG:-latest}
    build:
      context: .
      dockerfile: Dockerfile
    container_name: sphinxsearch
    restart: unless-stopped
    ports:
      - "127.0.0.1:9312:9306"
```

or modify Dockerfile.


1. First, you need to provide own sphinx configuration file **sphinx.conf**.
2. Then, execute `docker-compose build` and `docker-compose up` to copy configuration file into container, execute indexer and run sphinsearch daemon in the background.



#### [Inspired by macbre (Alpine based version)](https://github.com/macbre/docker-sphinxsearch)

