FROM nginx:latest
MAINTAINER Thao Tran <thawtran@gmail.com>


RUN mkdir -p /etc/nginx/globals && rm -vf /etc/nginx/sites-enabled/*
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/htmlglobal.conf /etc/nginx/globals/
COPY nginx/thaovutran.com.conf /etc/nginx/sites-enabled/

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /build/

RUN cd / && curl -L https://github.com/gohugoio/hugo/releases/download/v0.62.1/hugo_0.62.1_Linux-64bit.tar.gz | tar -xvzf-

ADD thaovutran /thaovutran

RUN cd /thaovutran && /hugo -d /usr/share/nginx/html
RUN mkdir -p /usr/share/nginx/html/feed && mv /usr/share/nginx/html/post/index.xml /usr/share/nginx/html/feed/
RUN find /usr/share/nginx/html -type f -name "index.xml" | grep -v feed | xargs rm -f
RUN perl -pi -e 's/post\/index.xml/feed/' /usr/share/nginx/html/feed/index.xml

ADD resume /usr/share/nginx/html/resume
