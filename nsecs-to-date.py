import datetime
import uptime
import time
import sys

now = time.time()
up = uptime.uptime()
boot = now - up
show = boot + float(sys.argv[1])

print(datetime.datetime.fromtimestamp(show).strftime("%Y-%m-%d %H:%M:%S.%f"))

