# Docker Tinyproxy ![alt text](https://raw.githubusercontent.com/daniel-middleton/docker-tinyproxy/master/other/banu_logo.png "Banu!")
A quick and easy Dockerised Tinyproxy with configurable ACL.

Find it on [GitHub](https://github.com/daniel-middleton/docker-tinyproxy).

Find it on [DockerHub](https://registry.hub.docker.com/u/dannydirect/tinyproxy/).

### Usage
---
##### Running a new Tinyproxy container

```
Usage:
    docker run -d --name='tinyproxy' -p <Host_Port>:8888 dannydirect/tinyproxy:latest <ACL>

        - Set <Host_Port> to the port you wish the proxy to be accessible from.
        - Set <ACL> to 'ANY' to allow unrestricted proxy access, or one or more space seperated IP/CIDR addresses for tighter security.

    Examples:
        docker run -d --name='tinyproxy' -p 6666:8888 dannydirect/tinyproxy:latest ANY
        docker run -d --name='tinyproxy' -p 7777:8888 dannydirect/tinyproxy:latest 87.115.60.124
        docker run -d --name='tinyproxy' -p 8888:8888 dannydirect/tinyproxy:latest 10.103.0.100/24 192.168.1.22/16
```

### Monitoring
---
##### Logs
`docker logs -f tinyproxy` will display a following tail of `/var/log/tinyproxy/tinyproxy.log`

##### Stats
Navigating to `http://tinyproxy.stats/` while connected to the proxy will display the Tinyproxy Stats page.

### Contribute
---
As always, contributions are appriciated. Simply open a Pull request.
