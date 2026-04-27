import json

with open('appwrite.json', 'r') as f:
    data = json.load(f)

data['functions'] = [
    {
        "$id": "fitkarma-core",
        "name": "FitKarma Core Dispatcher",
        "runtime": "node-22",
        "path": "functions/fitkarma-core",
        "entrypoint": "src/main.js",
        "execute": ["users"],
        "enabled": True,
        "logging": True,
        "events": [],
        "schedule": "",
        "timeout": 15
    }
]

with open('appwrite.json', 'w') as f:
    json.dump(data, f, indent=4)
