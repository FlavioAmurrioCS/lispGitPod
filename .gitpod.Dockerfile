FROM gitpod/workspace-full:latest

ARG slime_version="2.26.1"

ADD --chown=gitpod:gitpod https://raw.githubusercontent.com/FlavioAmurrioCS/lispGitPod/main/.emacs ${HOME}/.emacs
ADD --chown=gitpod:gitpod https://github.com/slime/slime/archive/v${slime_version}.tar.gz /tmp/slime.tar.gz
ADD --chown=gitpod:gitpod https://github.com/roswell/roswell/releases/download/v19.08.10.101/roswell_19.08.10.101-1_amd64.deb /tmp/roswell.deb

USER root
RUN apt-get update && \
  apt-get -y install --no-install-recommends emacs sbcl && \
  dpkg -i /tmp/roswell.deb && \
  rm -rf /var/lib/apt/lists/*

USER gitpod
RUN tar -xf /tmp/slime.tar.gz "--directory=${HOME}" && \
  mv "${HOME}/slime-${slime_version}" "${HOME}/slime" && \
  chown gitpod:gitpod -R ${HOME}/slime && \
  rm -rf /tmp/slime.tar.gz  /tmp/roswell.deb && \
  ros || echo

RUN ros install sbcl
RUN ros use sbcl
RUN ros install ailisp/linedit
RUN ros install ailisp/prepl
RUN ros install ailisp/cl-lsp

#   ros install cxxxr/lem cxxxr/cl-lsp

ENV PATH="${HOME}/.roswell/bin:${PATH}"
