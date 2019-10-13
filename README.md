# frps-docker

## USAGE
```
# frps.ini place in ./conf/frps.ini
docker run -d --name frp-server -p <HOST_PORT>:<CONTAINER_PORT> -v <ABSOLUTE_PATH>/conf:/conf --restart=always cloverzrg/frps-docker
```

## EXAMPLE
```
# /root/conf/frps.ini
[common]
bind_port = 7000
vhost_http_port = 8080
```

```
docker run -d --name frp-server -p 7000:7000 -p 8080:8080 -v /root/conf:/conf --restart=always cloverzrg/frps-docker
```

