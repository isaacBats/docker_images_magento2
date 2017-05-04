FROM million12/varnish

MAINTAINER Pengo Development Team

ENV VCL_CONFIG      /opt/varnish/varnish.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600 -p feature=+esi_ignore_https -p feature=+esi_disable_xml_check

RUN mkdir -p /opt/varnish/

ADD conf/varnish.vcl /opt/varnish/varnish.vcl