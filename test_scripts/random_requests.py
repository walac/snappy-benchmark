
import time
import urllib2
import json
import glob
from os.path import join, dirname, realpath
import random

class Transaction(object):
    def __init__(self):
        random.seed(time.time())

    def run(self):
        workload = join(dirname(realpath(__file__)), '..', 'workload', '*')
        reqs = glob.glob(workload)
        assert len(reqs) > 0

        fp = open(reqs[random.randint(0, len(reqs)-1)], 'r')
        data = json.load(fp)
        fp.close()
        data = json.dumps(data)

        headers = {
          "Content-Type": "application/json",
          "Content-Length": len(data),
          "Connection": "close"
        }

        request = urllib2.Request('http://localhost:8000/', data=data, headers=headers)

        start = time.time()
        resp = urllib2.urlopen(request)
        content = resp.read()
        latency = time.time() - start

        self.custom_timers['Latency'] = latency

if __name__ == '__main__':
    trans = Transaction()
    trans.run()
    print trans.custom_timers
