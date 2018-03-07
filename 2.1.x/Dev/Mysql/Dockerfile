FROM mysql:5.7
MAINTAINER "PengoStores < daniel.bautista@pengostores.com >"

RUN useradd -m -d /home/userapp -s /bin/bash userapp \
    && adduser userapp sudo \
    && mkdir /home/userapp/build \
    && chown -R userapp:userapp /home/userapp
# Delete user password to connect with ssh with empty password
RUN passwd userapp -d
