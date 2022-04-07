# see https://hub.docker.com/r/hashicorp/packer/tags for all available tags
FROM hashicorp/packer:light@sha256:f795aace438ef92e738228c21d5ceb7d5dd73ceb7e0b1efab5b0e90cbc4d4dcd
LABEL maintainer="Michael Myrtek <mmyrtek@bmj.com>"
RUN apk --update --no-cache add \
    ca-certificates \
    git \
    openssh-client \
    openssl \
    python3\
    py3-pip \
    py3-cryptography \
    rsync \
    sshpass

RUN apk --update add --virtual \
    .build-deps \
    python3-dev \
    libffi-dev \
    openssl-dev \
    build-base \
    curl \
    && pip3 install --upgrade \
    pip \
    cffi \
    && pip3 install \
    ansible \
    ansible-lint \
    && apk del \
    .build-deps \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/ansible \
    && echo 'localhost' > /etc/ansible/hosts 

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
