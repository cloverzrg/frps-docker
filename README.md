# frps-docker

## USAGE
```
docker run -d --name frp-server -p <HOST_PORT>:<CONTAINER_PORT> -v <ABSOLUTE_PATH>/conf:/conf --restart=always cloverzrg/frps-docker
```

## EXAMPLE
```
# vi /root/conf/frps.ini
[common]
bind_port = 7700
token = aNolEYwREgOD
vhost_http_port = 8080
vhost_https_port = 8443

dashboard_port = 7500
dashboard_user = admin
dashboard_pwd = aNolEYwREgOD1


tcp_mux = true
max_pool_count = 10
```

```
docker run -d --name frp-server -p 7700:7700 -p 8080:8080 -p 7500:7500 -v /root/conf:/conf --restart=always cloverzrg/frps-docker
```

```
# frpc.ini
[common]
server_addr = xxx.xxx.xxx.xxx
server_port = 7700
token = aNolEYwREgOD

[k-web]
type = http
local_port = 80
use_encryption = true
use_compression = true
custom_domains = xx.example.com
http_user = admin
http_pwd = bauJUnGEhuRn
```
