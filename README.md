# shadowsocks-libev with simple-obfs

## usage example

### example

docker run -it --rm hitian/ss ss-server -h

### client

```bash
docker run --name ss -p1086:1086 -p1087:1087 -e SERVER_HOST="xxx.xxx.xxx.xxx" -e SERVER_PORT=8111 -e PASSWORD="password" -e METHOD="chacha20-ietf-poly1305" -e PLUGIN_ARG="obfs-local" -e PLUGIN_OPS="obfs=tls;obfs-host=bing.com;fast-open;"
```
