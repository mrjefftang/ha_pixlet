ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG PIXLET_VERSION=0.29.1

# Install requirements for add-on
RUN \
  apk add --no-cache \
    curl \
    libc6-compat

# Download and install Pixlet
RUN \
  if [ "${BUILD_ARCH}" = "aarch64" ]; then \
    curl -fsSL -o /tmp/pixlet.tar.gz "https://github.com/tidbyt/pixlet/releases/download/v${PIXLET_VERSION}/pixlet_${PIXLET_VERSION}_linux_arm64.tar.gz"; \
  else \
    curl -fsSL -o /tmp/pixlet.tar.gz "https://github.com/tidbyt/pixlet/releases/download/v${PIXLET_VERSION}/pixlet_${PIXLET_VERSION}_linux_amd64.tar.gz"; \
  fi
RUN tar zxvf /tmp/pixlet.tar.gz -C /usr/bin pixlet

WORKDIR /data

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
