ARG UBUNTU_RELEASE=bionic

FROM ubuntu:${UBUNTU_RELEASE}

ARG UBUNTU_RELEASE

ENV UBUNTU_RELEASE=${UBUNTU_RELEASE}

ARG USER=hanxi
ENV USER=${USER}
ENV HOME=/home/${USER}

RUN apt-get update && \
	apt-get install sudo -y && \
	adduser --disabled-password --gecos '' ${USER} && \
	adduser ${USER} sudo && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# {{{ lang stuff

ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN
RUN apt-get update && \
	apt-get install -y language-pack-zh-hans && \
	rm -rf /var/lib/apt/lists/*

# }}}

# Required for `clear` command to work, etc.
ENV TERM screen-256color

ENV DOCKER_CLI_SHA256 "918372dd8cc56616b32b0f67432e2f6b4b27541728d6f9529543a5d73d955100"
ENV DOCKER_CLI_VERSION "18.09.3"

COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

CMD ["/bin/bash"]
