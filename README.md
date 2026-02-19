# frps-docker
<a href="https://hub.docker.com/r/cloverzrg/frps-docker/tags?page=1&ordering=last_updated"><img src="https://img.shields.io/github/v/tag/cloverzrg/frps-docker?label=version&style=flat-square" alt="Latest Version"></a>
  <a href="https://hub.docker.com/r/cloverzrg/frps-docker/"><img src="https://img.shields.io/docker/stars/cloverzrg/frps-docker.svg?style=flat-square&logo=docker" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/cloverzrg/frps-docker/"><img src="https://img.shields.io/docker/pulls/cloverzrg/frps-docker.svg?style=flat-square&logo=docker" alt="Docker Pulls"></a>
 
 ## Build Status: 
  [![Build Status](https://drone.jeongen.com/api/badges/cloverzrg/frps-docker/status.svg)](https://drone.jeongen.com/cloverzrg/frps-docker)


## Dockerfile. 
https://github.com/cloverzrg/frps-docker


## USAGE
#### 1. use host network
`docker run -d --name frp-server --net=host -v /var/docker/frps/conf/frps.ini:/conf/frps.ini --restart=always cloverzrg/frps-docker`

#### 2. expose port
`docker run -d --name frp-server -p <HOST_PORT>:<CONTAINER_PORT> -v <ABSOLUTE_PATH>/conf:/conf --restart=always cloverzrg/frps-docker`

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
dashboard_pwd = aNolEYwREgOF1


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

[xx-admin-web]
type = http
local_port = 80
use_encryption = true
use_compression = true
custom_domains = xx.example.com
http_user = admin
http_pwd = bauJUnGEhuRn
```
