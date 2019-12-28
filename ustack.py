import re
import sys
import json
d={}
a = re.sub('\+[\d]*', '', sys.stdin.read().replace('\n','')).split('@')
a.pop(0)
for item in a:
    key, count = item.split(':')
    d[key] = d[key] + int(count) if key in d else 0

print(json.dumps(d, indent=2))
