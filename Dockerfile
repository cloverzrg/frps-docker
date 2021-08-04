FROM --platform=$BUILDPLATFORM golang:alpine as builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG DRONE_TAG
ENV CGO_ENABLED 0
ENV GOOS $TARGETOS
ENV GOARCH $TARGETARCH
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM, GOOS $GOOS, GOARCH $GOARCH"
RUN apk update && apk add --no-cache git build-base make
ENV FRP_VERSION $DRONE_TAG
RUN git clone --branch v${FRP_VERSION} https://github.com/fatedier/frp.git
WORKDIR /go/frp
# RUN make frps
RUN go build -trimpath -ldflags "-s -w" -o bin/frps ./cmd/frps

FROM --platform=$TARGETPLATFORM alpine:latest
RUN apk update && apk add --no-cache ca-certificates tzdata
COPY --from=builder /go/frp/bin/frps /frps/
ENV TZ=Asia/Shanghai
RUN mkdir /conf
RUN uname -a
VOLUME /conf
WORKDIR /frps
ENTRYPOINT ["./frps","-c","/conf/frps.ini"]
