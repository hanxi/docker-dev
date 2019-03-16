FROM tmux-nvim-dev

ARG USER=hanxi
ENV USER=${USER}
ENV HOME=/home/${USER}


COPY build.sh /tmp/build.sh
RUN bash /tmp/build.sh && \
	rm /tmp/build.sh

USER ${USER}
COPY dotfiles.sh /tmp/dotfiles.sh
RUN bash /tmp/dotfiles.sh

USER root
EXPOSE 22
ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN rm /tmp/dotfiles.sh
ENTRYPOINT ["entrypoint.sh"]


