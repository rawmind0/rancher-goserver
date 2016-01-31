rancher-gocd-server
=======================

Builds a docker image for gocd server based in rancher-base

To build:

```
docker build -t <registry>/rancher-goserver:<version> .
```

To run:

Gocd server: Starts gocd server and configures it

```
docker run -td --name go-server \
-v <work-volume> /opt/go-server/work
<registry>/rancher-goserver:<version>

```

# How it works

* The docker has the entrypoint /usr/bin/start.sh, that runs go-server.
* Config .arams could be modified overriding these env variables:

```
SERVER_MEM="512m"
SERVER_MAX_MEM="1024m"
SERVER_MAX_PERM_GEN="256m"
SERVER_MIN_PERM_GEN="128m"
GO_SERVER_PORT="8153"
GO_SERVER_SSL_PORT="8154"
SERVER_DIR="$GOCD_HOME"
SERVER_WORK_DIR="$SERVER_DIR"

```
