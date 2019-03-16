FROM base-dev

ARG USER=hanxi
ENV USER=${USER}
ENV HOME=/home/${USER}

COPY build.sh /tmp/build.sh

RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

CMD ["/bin/bash"]
