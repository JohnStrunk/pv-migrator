FROM fedora:27

RUN dnf install -y \
      bash \
      findutils \
      rsync \
    && dnf clean all && \
    rm -rf /var/cache/yum

COPY entry.sh /

RUN mkdir -p /source && chmod 555 /source && \
    mkdir -p /target && chmod 777 /target && \
    chmod 755 /entry.sh

ENTRYPOINT ["/entry.sh"]
