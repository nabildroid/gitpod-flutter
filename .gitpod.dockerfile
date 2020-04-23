FROM gitpod/workspace-full:latest

LABEL maintainer="vitortorresvt@gmail.com"

USER root

RUN apt-get update -y
RUN apt-get install inotify-tools rsync -y
RUN apt-get install -y gcc make build-essential wget curl unzip apt-utils xz-utils libkrb5-dev gradle libpulse0 android-tools-adb android-tools-fastboot

USER gitpod

# Flutter
ENV FLUTTER_HOME="/home/gitpod/flutter"
RUN git clone https://github.com/flutter/flutter $FLUTTER_HOME
RUN $FLUTTER_HOME/bin/flutter channel master
RUN $FLUTTER_HOME/bin/flutter upgrade
RUN $FLUTTER_HOME/bin/flutter precache
RUN $FLUTTER_HOME/bin/flutter config --enable-web --no-analytics
ENV PUB_CACHE=/workspace/.pub_cache
