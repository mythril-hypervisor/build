FROM archlinux/base
MAINTAINER Adam Schwalm <adamschwalm@gmail.com>

RUN pacman -y --noconfirm -S rustup gcc make nasm python
RUN useradd -m mythril

USER mythril
RUN rustup set profile minimal
RUN rustup toolchain install nightly-2020-05-14
RUN rustup component add rust-src
RUN rustup component add rustfmt
RUN cargo install cargo-xbuild

# These must still point to the right place, even
# when running as a different user (like root)
ENV RUSTUP_HOME /home/mythril/.rustup
ENV CARGO_HOME /home/mythril/.cargo

WORKDIR /src