FROM alpine:3.2
MAINTAINER Ian Coffey "icoffey@engineyard.com"

EXPOSE 80

RUN apk update && \
    apk upgrade && \
    apk add curl \
            wget \
            bash \
            git \
            build-base \
            linux-headers \
            ruby-dev \
            libffi-dev && \
    rm -rf /var/cache/apk/*

RUN gem install bundler

RUN mkdir /app

WORKDIR /app

ADD . /app

RUN bundle install

CMD ["unicorn","-p","80"]
