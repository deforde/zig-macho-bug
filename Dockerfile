from ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Africa/Johannesburg

RUN apt update && apt install -y \
    clang \
    lld \
    make \
    curl \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

RUN mkdir zig && \
    curl -L https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.2375+771d07268.tar.xz | \
    tar -xJ --strip-components=1 -C /home/zig
ENV PATH=$PATH:/home/zig

RUN curl -LO https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.3.sdk.tar.xz && \
    tar -xf MacOSX11.3.sdk.tar.xz && \
    rm MacOSX11.3.sdk.tar.xz

COPY build.mk /home/test/build.mk
COPY Dockerfile /home/test/Dockerfile
COPY foo.c /home/test/foo.c
COPY foo.h /home/test/foo.h
COPY main.c /home/test/main.c
COPY make-clang-cross.mk /home/test/make-clang-cross.mk
COPY make-clang-native.mk /home/test/make-clang-native.mk
COPY make-zig-cross.mk /home/test/make-zig-cross.mk
COPY make-zig-native.mk /home/test/make-zig-native.mk

