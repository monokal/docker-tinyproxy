docker-tinyproxy
================
A quick and easy Dockerised Tinyproxy.

Usage
-----
Assuming you've got Docker installed, all you need is the following command:

```
Usage:
    docker run -d --name='tinyproxy' -p <Host_Port>:8888 dannydirect/tinyproxy:latest '<Allowed_IP>'
    
        - Set <Host_Port> to the port you wish the proxy to be accessible from.
        - Set <Allowed_IP> to 'ANY' to allow unrestricted proxy access, or a specific IP/CIDR for tighter security.
```

Find it on Docker Hub
---------------------
https://registry.hub.docker.com/u/dannydirect/tinyproxy/

Contribute
----------
As always, contributions are appriciated. Simply open a Pull request.
