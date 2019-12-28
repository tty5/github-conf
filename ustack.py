import re
import sys
import json
d={}
a = re.sub('\+[\d]*', '', open(sys.argv[1]).read().replace('\n','')).split('@')
a.pop(0)
for item in a:
    key, count = item.rsplit(':', 1)
    d[key] = d[key] + int(count) if key in d else int(count)

print(json.dumps(d, indent=2))
