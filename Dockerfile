
# set the base image to Debian
# https://hub.docker.com/_/debian/
FROM ubuntu:latest
RUN apt-get update

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        wget 

ENV NVM_DIR /usr/local/nvm
RUN mkdir $NVM_DIR
ENV NODE_VERSION 12

# Install nvm with node and npm
RUN curl -o- curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH
# confirm installation
# RUN node -v
# RUN npm -v

# install ruby
RUN apt-get install -y git ruby-full

# install Bundler
RUN gem install bundler


# Fix UTF8 character encoding issue! Add locales and support for UTF 8 Source: https://github.com/jekyll/jekyll/issues/4268
# Install program to configure locales
RUN apt-get install -y locales

# RUN dpkg-reconfigure locales && \
#   locale-gen C.UTF-8 && \
#   /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# cypress requirements: https://docs.cypress.io/guides/guides/continuous-integration.html#Advanced-setup
RUN apt-get install -y libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
# set out application folder
WORKDIR /project

# just wait :) used only for docker-compose, so image doesn't exit right after starting with docker-compose
CMD ["/bin/bash",  "-c",  "tail -f /dev/null"]

# RUN useradd -ms /bin/bash docker
# USER docker
