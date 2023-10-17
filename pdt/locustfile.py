from locust import HttpUser, task
import logging
import os
import json
import requests

fn = os.environ.get("TEST_DATA_FILE", "./event-2022-11.json")
f = open(fn)
eventss = []
# print(f)
for line in f:
    d = json.loads(line)
    # del d['profileId']
    # del d['systemProperties']
    if '_source' in d and 'profileId' in d['_source']:
        del d['_source']['profileId']
    # if '_source' in d and 'source' in d['_source'] and 'profileId' in d['_source']['source']:
    #     del d['_source']['source']['profileId']
    if '_source' in d and 'systemProperties' in d['_source']:
        del d['_source']['systemProperties']
    eventss.append(d)
cnt = len(eventss)
i = 0
logging.info("total event %d", cnt)
# base_url
class HelloWorldUser(HttpUser):
    @task
    def hello_world(self):
        global i
        if i >= cnt:
            self.environment.reached_end = True
            self.environment.runner.quit()
            return
        ev = eventss[i]
        data = {"events": [ev]}
        i += 1
        self.client.post(
            "/eventcollector",
            json=data
            # ,auth=HTTPBasicAuth("prime", "karaf"),
        )
        self.client.cookies.clear()
