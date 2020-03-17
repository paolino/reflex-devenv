
## Dockerfile for a haskell environment
FROM       debian:sid

MAINTAINER Paolo Veronelli <paolo.veronelli@gmail.com>

ENV LAST_UPDATED 2019-06-23

## ensure locale is set during build
ENV LANG            C.UTF-8
ENV HOME /root

#common
RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y\
    ca-certificates\
    g++\
    curl\
    vim\
    git\
    wget\
    make\
    gnupg\
    busybox\
    procps\
    bzip2\
    xz-utils\
    zlib1g-dev\
    docker.io\
    libtinfo-dev\
    locales\
    sudo
    

Run localedef -c -f UTF-8 -i en_US en_US.UTF-8


env USER developer
RUN useradd $USER -s /bin/bash -m -u 1000 -G sudo 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN gpasswd -A $USER docker

env HOME /home/$USER
WORKDIR $HOME
RUN mkdir /etc/nix
RUN echo 'sandbox = false' > /etc/nix/nix.conf
USER $USER
ENV LC_ALL=C.UTF-8


WORKDIR $HOME
RUN git clone https://github.com/reflex-frp/reflex-platform
RUN PATH=$HOME/.local/bin:$PATH
RUN curl https://nixos.org/nix/install | sh
RUN echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >>  $HOME/.bashrc
user root
ADD run.sh /usr/local/bin
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
ENTRYPOINT ["run.sh"]
