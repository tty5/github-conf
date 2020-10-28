cd "$(dirname "$0")"
python3 vmess2json.py   --subscribe "$(cat /tmp/v2r.url)" -o /tmp/v2r.json && echo restart v2r && docker restart v2r

