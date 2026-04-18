FROM alpine:latest
RUN apk add --no-cache ca-certificates curl

ARG TARGETARCH

RUN case "${TARGETARCH}" in \
    "amd64")  ARCH="x86_64" ;; \
    "arm64")  ARCH="arm64" ;; \
    "386")    ARCH="i386" ;; \
    *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    wget https://github.com/rusq/slackdump/releases/latest/download/slackdump_Linux_${ARCH}.tar.gz && \
    tar -xzf slackdump_Linux_${ARCH}.tar.gz && \
    mv slackdump /usr/local/bin/ && \
    rm slackdump_Linux_${ARCH}.tar.gz

WORKDIR /data
ENTRYPOINT ["slackdump"]
