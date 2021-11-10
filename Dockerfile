FROM debian:11.1

# Install dependencies
RUN apt-get update \
    && apt-get -y install default-libmysqlclient-dev libpq-dev unixodbc-dev \
    && apt-get -y install  libmariadb-client-lgpl-dev-compat wget

# Install sphinx binary
RUN mkdir -pv /opt/sphinx/log /opt/sphinx/index \
    && mkdir -pv /var/lib/sphinxsearch/itemsSourceMain \
    && mkdir -pv /var/lib/sphinxsearch/itemsSourceDelta \
    /var/run/sphinxsearch/

COPY sphinxsearch.tar.gz /tmp/
RUN cd /opt/sphinx && tar -xf /tmp/sphinxsearch.tar.gz
RUN rm /tmp/sphinxsearch.tar.gz

# Logs to stdout
RUN ln -sv /dev/stdout /opt/sphinx/log/query.log \
    	&& ln -sv /dev/stdout /opt/sphinx/log/searchd.log

# Point to sphinx binaries
ENV PATH "${PATH}:/opt/sphinx/sphinx-3.4.1/bin"

# Installation check
RUN indexer -v

# Copy own configuration file
COPY ./sphinx.conf /etc/sphinxsearch/sphinx.conf
COPY ./start.sh /

# Set permissions on copied files
RUN chmod 777 /start.sh
RUN chmod 777 /etc/sphinxsearch/
RUN chmod 777 /sphinx_rotate.sh
EXPOSE 9312 9306

# Start indexing and search daemon
CMD ["/start.sh"]