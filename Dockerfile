#
# rtl Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV RTL_VERSION v0.13.5

# Update & install packages
RUN apt-get update && \
    apt-get install -y gnupg git curl apt-transport-https wget

#Add yarn repository
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - 

# Update & install packages
RUN apt-get update && \
    apt-get install -y nodejs

# Get rtl and install it
RUN wget https://github.com/Ride-The-Lightning/RTL/archive/v${RTL_VERSION}.tar.gz && \
    tar xf v${RTL_VERSION}.tar.gz && \
    cd RTL-${RTL_VERSION} && \
    npm install --only=prod

WORKDIR /RTL-${RTL_VERSION}

# Copy config file
COPY RTL-Config.json /RTL-${RTL_VERSION}/RTL-Config.json

# Let's GO!!
CMD ["node", "rtl"]
