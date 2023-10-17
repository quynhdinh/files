from locust import HttpUser, task
import json
import logging
import os

fn = os.environ.get("TEST_DATA_FILE", "/tmp/profiles.json")
f = open(fn)
profiles = []
for line in f:
    d = json.loads(line)
    profiles.append(d)
cnt = len(profiles)
i = 0
logging.error("total profiles %d", cnt)

class UnomiUser(HttpUser):
    @task
    def test(self):
        global i
        if i >= cnt:
            self.environment.reached_end = True
            self.environment.runner.quit()
            return
        source = profiles[i]['_source']
        data = {
            "itemId": source['itemId'],
            "source": {
                "properties": source['properties']
            }
        }
        data = {"data": [data]}
        i += 1
        self.client.post(
            "/cxs/profiles/bulkUpdate",
            json=data
        )
        self.client.cookies.clear()