cd "$(dirname "$0")"
python3 vmess2json.py --subscribe "$(cat /tmp/v2r.url)" -o /tmp/v2r-u.json &&
echo restart v2r && cp /tmp/v2r-u.json /tmp/v2r.json &&  docker restart v2r

