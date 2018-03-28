FROM postgres

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates curl file \
    build-essential \
    libpq-dev \
    autoconf automake autotools-dev libtool xutils-dev && \
    rm -rf /var/lib/apt/lists/*

ENV SSL_VERSION=1.0.2n

RUN curl https://www.openssl.org/source/openssl-$SSL_VERSION.tar.gz -O && \
    tar -xzf openssl-$SSL_VERSION.tar.gz && \
    cd openssl-$SSL_VERSION && ./config && make depend && make install && \
    cd .. && rm -rf openssl-$SSL_VERSION*

ENV OPENSSL_LIB_DIR=/usr/local/ssl/lib \
    OPENSSL_INCLUDE_DIR=/usr/local/ssl/include \
    OPENSSL_STATIC=1

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly -y

ENV PATH=/root/.cargo/bin:$PATH