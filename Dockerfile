FROM ubuntu:16.04

# Register arguments
ARG cname_flags=-DENABLE_CONTENT_PATCHING=OFF
ARG steemd_version=0.4.3
ARG rpc_port=8090

# Install necessary packages
RUN apt-get update
RUN apt-get install -qy build-essential git libssl-dev m4 yasm autogen automake libtool doxygen python-dev autotools-dev libicu-dev libbz2-dev cmake g++ wget pkg-config libgmp-dev libboost-all-dev

# Clone steem repository.
WORKDIR /usr/local/steem
RUN git clone https://github.com/steemit/steem src

# Build steemd
WORKDIR /usr/local/steem/src
RUN git checkout "v${steemd_version}"
RUN git submodule update --init --recursive
RUN cmake ${cname_flags} .
RUN make
RUN make install

# Copy files that are needed.
COPY entrypoint.sh /usr/local/steem/entrypoint.sh
COPY config.ini /usr/local/steem/config.ini

# Expose the RPC port.
EXPOSE ${rpc_port}

# Specify the entry point.
WORKDIR /usr/local/steem
ENTRYPOINT ["./entrypoint.sh"]
