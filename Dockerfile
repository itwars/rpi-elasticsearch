# Pull base image.
FROM itwars/rpi-java8
MAINTAINER Vincent RABAH <vincent.rabah@gmail.com>

ENV ES_PKG_NAME elasticsearch-1.5.1

# Install Elasticsearch.
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y wget && \
  cd / && \
  wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
