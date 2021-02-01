ARG VARIANT="stretch"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ADD https://github.com/roswell/roswell/releases/download/v21.01.14.108/roswell_21.01.14.108-1_amd64.deb /tmp/roswell.deb

RUN apt update && \
  apt upgrade -y && \
  apt install -y build-essential emacs && \
  dpkg -i /tmp/roswell.deb && \
  rm -rf /var/lib/apt/lists/* /tmp/roswell.deb

ARG slime_version="2.26.1"
ENV PATH="/home/gitpod/.roswell/bin:${PATH}"

RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

USER gitpod
ADD --chown=gitpod:gitpod https://github.com/slime/slime/archive/v${slime_version}.tar.gz /tmp/slime.tar.gz
ADD --chown=gitpod:gitpod https://raw.githubusercontent.com/FlavioAmurrioCS/lispGitPod/main/.emacs /home/gitpod/.emacs
RUN tar -xf /tmp/slime.tar.gz "--directory=/home/gitpod" && \
  mv "/home/gitpod/slime-${slime_version}" "/home/gitpod/slime" && \
  rm -rf /tmp/slime.tar.gz

RUN ros install ailisp/linedit && \
  ros install ailisp/prepl && \
  ros install ailisp/cl-lsp
