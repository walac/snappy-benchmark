
import random
import time
import urllib2
import time
import json

class Transaction(object):
    def __init__(self):
        pass

    def run(self):
        data = \
            '''
            {
                "stacks":[[[0,11723767],[1, 65802]]],
                "memoryMap":[["xul.pdb","44E4EC8C2F41492B9369D6B9A059577C2"],
                            ["wntdll.pdb","D74F79EB1F8D4A45ABCD2F476CCABACC2"]],
                "version":4
            }
            '''

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

        self.custom_timers['Example_Timer'] = latency

if __name__ == '__main__':
    trans = Transaction()
    trans.run()
    print trans.custom_timers
