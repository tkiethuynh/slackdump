FROM alpine:latest
RUN apk add --no-cache ca-certificates curl

ARG TARGETARCH

RUN case "${TARGETARCH}" in \
    "amd64")  ARCH="amd64" ;; \
    "arm64")  ARCH="arm64" ;; \
    "arm")    ARCH="arm" ;; \
    *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    wget https://github.com/rusq/slackdump/releases/latest/download/slackdump_linux_${ARCH}.tar.gz && \
    tar -xzf slackdump_linux_${ARCH}.tar.gz && \
    mv slackdump /usr/local/bin/ && \
    rm slackdump_linux_${ARCH}.tar.gz

WORKDIR /data
ENTRYPOINT ["slackdump"]
