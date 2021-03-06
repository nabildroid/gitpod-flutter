FROM gitpod/workspace-full:latest

LABEL maintainer="vitortorresvt@gmail.com"

USER root

RUN apt-get update -y

# Remote async
RUN apt-get install inotify-tools rsync -y
RUN brew update
RUN brew install watchman

ENV WORKSPACE="/workspace/gitpod-flutter"
ENV SYNC="/workspace/gitpod-flutter/sync.sh"
RUN echo "$(touch $SYNC)"
RUN echo "$(echo \"for i in $@\" >> $SYNC)" 
RUN echo "$(echo \"do\" >> $SYNC)"
RUN echo "$(echo \"rsync -e 'ssh -p NGROK_PORT_HERE' \$i SSH_USER_NAME_HERE@0.tcp.ngrok.io:LOCAL_DIR_HERE/\$i\" >> $SYNC)" 
RUN echo "$(echo \"done\" >> $SYNC)" 

RUN watchman watch $WORKSPACE

RUN watchman -- trigger . rsync -- sh $SYNC
 
