const fs = require('fs');
const data = JSON.parse(fs.readFileSync('appwrite.json', 'utf8'));
data.functions = [
    {
        "$id": "fitkarma-core",
        "name": "FitKarma Core Dispatcher",
        "runtime": "node-22",
        "path": "functions/fitkarma-core",
        "entrypoint": "src/main.js",
        "execute": ["users"],
        "enabled": true,
        "logging": true,
        "events": [],
        "schedule": "",
        "timeout": 15
    }
];
fs.writeFileSync('appwrite.json', JSON.stringify(data, null, 4), 'utf8');
console.log('Fixed appwrite.json');
