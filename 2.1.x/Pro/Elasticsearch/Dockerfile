FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.0

MAINTAINER "Pengo Development Team"

USER root

RUN mkdir -m 777 -p /var/lib/elasticsearch/ && mkdir -m 777 -p /var/log/elasticsearch/ && rm /usr/share/elasticsearch/config/elasticsearch.yml

COPY conf/elasticsearch.yml /usr/share/elasticsearch/config/

RUN chown elasticsearch:elasticsearch config/elasticsearch.yml \
    && chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/ \
    && chown -R elasticsearch:elasticsearch /var/log/elasticsearch/

USER elasticsearch