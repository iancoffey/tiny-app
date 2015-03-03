FROM ubuntu:trusty
MAINTAINER Ian Coffey "ian@packethost.net"

USER root

EXPOSE 80

# Install teh rubez
RUN apt-get update
RUN apt-get -y install build-essential git libssl-dev curl git

RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv

RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN rbenv install 2.1.5

ENV RBENV_VERSION 2.1.5

RUN gem install bundler
RUN rbenv rehash
# fin rubez

RUN mkdir /app

WORKDIR /app

ADD . /app

RUN bundle install

CMD ["unicorn","-p","80"]
