FROM --platform=$BUILDPLATFORM golang:alpine AS builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG DRONE_TAG
ENV CGO_ENABLED=0
ENV GOOS=$TARGETOS
ENV GOARCH=$TARGETARCH
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM, GOOS $GOOS, GOARCH $GOARCH"
RUN apk update && apk add --no-cache git build-base make ca-certificates tzdata
RUN git clone https://github.com/fatedier/frp.git && \
    cd frp && \
    if [ -n "$DRONE_TAG" ] && [ "$DRONE_TAG" != "master" ]; then git checkout v${DRONE_TAG}; fi
RUN pwd && ls -lah
WORKDIR /go/frp
RUN ls -lah
RUN go build -trimpath -ldflags "-s -w" -o bin/frps ./cmd/frps

FROM alpine:latest
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /go/frp/bin/frps /frps/
ENV TZ=Asia/Shanghai
RUN mkdir /conf
RUN uname -a
VOLUME /conf
WORKDIR /frps
ENTRYPOINT ["./frps","-c","/conf/frps.ini"]
