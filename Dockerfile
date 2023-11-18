FROM debian:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    clang-14 \
    curl \
    gcc \
    git \
    g++ \
    make \
    bison \
    flex \
    cmake \
    python3 \
    python3-setuptools \
    python3-pyroute2 \
    zip \
    libelf-dev \
    zlib1g-dev \
    libedit-dev \
    libfl-dev \
    libllvm14 llvm-14-dev libclang-14-dev libpolly-14-dev \
    libluajit-5.1-dev \
    luajit \
    arping \
    iperf \
    ethtool \
    kmod \
    linux-headers-$(uname -r) \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV BCC_VERSION v0.28.0
RUN git clone --depth 1 --branch "$BCC_VERSION" https://github.com/iovisor/bcc.git /usr/src/bcc \
    && ( \
        cd /usr/src/bcc \
        && mkdir build \
        && cd build \
        && cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
        && make \
        && make install \
    ) \
    && rm -rf /usr/src/bcc

RUN git clone --depth 1 https://github.com/brendangregg/FlameGraph /work/FlameGraph

WORKDIR /work

ENTRYPOINT ["/bin/bash"]