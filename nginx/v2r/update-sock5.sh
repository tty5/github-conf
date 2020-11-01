# docker run --name v2r --log-opt max-size=1m --user :1080 -v /tmp/v2r.json:/etc/v2ray/config.json --network host --restart always -d tty/v2r

# docker logs v2r -f |tee >(grep '\[direct\]' ) > >(GREP_COLOR='01;36' grep 'default route')

cd "$(dirname "$0")"
python3 vmess2json.py --subscribe "$(cat /tmp/v2r.url)" -o /tmp/v2r-u.json &&
echo restart v2r && cp /tmp/v2r-u.json /tmp/v2r.json &&  docker restart v2r

