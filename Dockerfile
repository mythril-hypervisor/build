FROM archlinux/base
MAINTAINER Adam Schwalm <adamschwalm@gmail.com>

RUN pacman -y --noconfirm -S rustup gcc make nasm python

USER root
RUN rustup set profile minimal
RUN rustup toolchain install nightly-2020-03-11
RUN rustup component add rust-src
RUN rustup component add rustfmt
RUN cargo install cargo-xbuild

WORKDIR /src