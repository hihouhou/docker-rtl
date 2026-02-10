        #
# rtl Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV RTL_VERSION=v0.15.8
ENV NODE_MAJOR=22

# Update & install packages
RUN apt-get update && \
    apt-get install -y gnupg2 git curl apt-transport-https wget ca-certificates

# Fetch Nodejs repository
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Update & install packages
RUN apt-get update && \
    apt-get install -y nodejs

# Get rtl and install it
RUN wget https://github.com/Ride-The-Lightning/RTL/archive/refs/tags/${RTL_VERSION}.tar.gz && \
    tar xf ${RTL_VERSION}.tar.gz && \
    mv RTL-$(echo $RTL_VERSION | cut -c2-) RTL && \
    cd RTL && \
    npm install --omit=dev --legacy-peer-deps

WORKDIR /RTL

RUN pwd

# Copy config file
COPY RTL-Config.json .

# Let's GO!!
CMD ["node", "rtl"]
