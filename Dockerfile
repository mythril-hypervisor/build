FROM archlinux/base@sha256:b51848238f91eb50f3962041b2a23b7a1e4d588c53a0ba8419d4e3b28d652e7f
MAINTAINER Adam Schwalm <adamschwalm@gmail.com>

RUN pacman -y --noconfirm -S base-devel libffi bc rustup nasm python grub libisoburn qemu git
RUN useradd -m mythril

USER mythril
RUN rustup set profile minimal
RUN rustup toolchain install nightly-2020-11-16
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