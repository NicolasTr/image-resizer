FROM phusion/baseimage:0.9.16

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN add-apt-repository ppa:dhor/myway \
    && curl -sL https://deb.nodesource.com/setup_4.x | sudo bash - \
    && apt-get update \
    && apt-get install -y nodejs --force-yes \
    && apt-get install -y git libvips-dev --force-yes \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD package.json /srv/app/package.json
RUN cd /srv/app/ \
    && npm install --unsafe-perm \
    && apt-get clean && npm cache clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD . /srv/app
ADD docker /
