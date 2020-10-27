FROM golang:alpine as builder
RUN apk update && apk add --no-cache git build-base make tzdata
ENV FRP_VERSION 0.34.1
RUN git clone --branch v${FRP_VERSION} https://github.com/fatedier/frp.git
WORKDIR /go/frp
RUN make frps

FROM alpine:latest
RUN apk update && apk add --no-cache ca-certificates tzdata
COPY --from=builder /go/frp/bin/frps /frps/
ENV TZ=Asia/Shanghai
RUN mkdir /conf
VOLUME /conf
WORKDIR /frps
ENTRYPOINT ["./frps","-c","/conf/frps.ini"]
