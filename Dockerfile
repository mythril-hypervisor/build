FROM archlinux/base
MAINTAINER Adam Schwalm <adamschwalm@gmail.com>

RUN pacman -y --noconfirm -S base-devel libffi bc rustup nasm python
RUN useradd -m mythril

USER mythril
RUN rustup set profile minimal
RUN rustup toolchain install nightly-2020-08-13
RUN rustup component add rust-src
RUN rustup component add rustfmt

# These must still point to the right place, even
# when running as a different user (like root)
ENV RUSTUP_HOME /home/mythril/.rustup
ENV CARGO_HOME /home/mythril/.cargo

# The user might not be UID 1000, so allow anyone to write
# to this user's home.
RUN chmod 777 -R /home/mythril/

WORKDIR /src