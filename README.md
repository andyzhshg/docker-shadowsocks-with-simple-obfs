# shadowsocks-libev with simple-obfs

## usage example

### example

docker run -it --rm hitian/ss ss-server -h

### client

```bash
docker run \
    --name ss \
    -p1086:1086 \
    -p1087:1087 \
    -e SERVER_HOST="xxx.xxx.xxx.xxx" \
    -e SERVER_PORT=8111 \
    -e PASSWORD="password" \
    -e METHOD="chacha20-ietf-poly1305" \
    -e PLUGIN="obfs-local" \
    -e PLUGIN_OPS="obfs=tls;obfs-host=bing.com;fast-open;" \
    -d \
    andyzhshg/shadowsocks-with-simple-obfs
```

#### run behind a socks5 proxy

Specify `PROXY_IP` and `PROXY_PORT`, and run `docker run` with `--cap-add=NET_ADMIN` provided.

```bash
docker run \
    --name ss \
    -p1086:1086 \
    -p1087:1087 \
    -e PROXY_IP="123.123.123.123" \
    -e PROXY_PORT=1080 \
    -e SERVER_HOST="xxx.xxx.xxx.xxx" \
    -e SERVER_PORT=8111 \
    -e PASSWORD="password" \
    -e METHOD="chacha20-ietf-poly1305" \
    -e PLUGIN="obfs-local" \
    -e PLUGIN_OPS="obfs=tls;obfs-host=bing.com;fast-open;" \
    --cap-add=NET_ADMIN \
    -d \
    andyzhshg/shadowsocks-with-simple-obfs:redsocks
```
