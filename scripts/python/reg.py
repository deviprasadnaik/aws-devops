import re
import json

data = {
  "Records": [
    {
      "eventName": "StartInstances",
      "sourceIPAddress": "54.23.110.9",
      "additionalEventData": {
        "clientIp": "100.21.33.44"
      }
    }
  ]
}

pattern = r"([\d].[\d].[\d].[\d]+)"

jsonifyData=json.dumps(data)

matches = re.findall(pattern, jsonifyData)
print(matches)