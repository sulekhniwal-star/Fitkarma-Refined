import json
import sys

# Load appwrite.json
with open('appwrite.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Update collections with indexes
for i, coll in enumerate(data['collections']):
    cid = coll.get('$id', '')
    
    if cid == 'users':
        coll['indexes'] = [{
            "key": "userId_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "attributes": ["userId"]
        }]
    
    elif cid == 'food_logs':
        coll['indexes'] = [{
            "key": "user_date_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "attributes": ["userId", "loggedAt"]
        }]
    
    elif cid == 'bp_readings':
        coll['indexes'] = [{
            "key": "user_time_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "attributes": ["userId", "measuredAt"]
        }]
    
    elif cid == 'social_posts':
        coll['indexes'] = [{
            "key": "feed_idx",
            "type": "key",
            "status": "available",
            "orders": ["DESC"],
            "attributes": ["postedAt"]
        }]
    
    elif cid == 'festivals':
        coll['indexes'] = [{
            "key": "start_date_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "attributes": ["startDate"]
        }]
    
    elif cid == 'karma_events':
        coll['indexes'] = [{
            "key": "user_occurred_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "attributes": ["userId", "occurredAt"]
        }]

# Update tablesDB with indexes (for the tablesDB section)
for i, tbl in enumerate(data['tables']):
    tid = tbl.get('$id', '')
    
    if tid == 'users':
        tbl['indexes'] = [{
            "key": "userId_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "columns": ["userId"]
        }]
    
    elif tid == 'food_logs':
        tbl['indexes'] = [{
            "key": "user_date_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "columns": ["userId", "loggedAt"]
        }]
    
    elif tid == 'bp_readings':
        tbl['indexes'] = [{
            "key": "user_time_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "columns": ["userId", "measuredAt"]
        }]
    
    elif tid == 'social_posts':
        tbl['indexes'] = [{
            "key": "feed_idx",
            "type": "key",
            "status": "available",
            "orders": ["DESC"],
            "columns": ["postedAt"]
        }]
    
    elif tid == 'festivals':
        tbl['indexes'] = [{
            "key": "start_date_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "columns": ["startDate"]
        }]
    
    elif tid == 'karma_events':
        tbl['indexes'] = [{
            "key": "user_occurred_idx",
            "type": "key",
            "status": "available",
            "orders": ["ASC"],
            "columns": ["userId", "occurredAt"]
        }]

# Update storage buckets - consolidate into fitkarma-media
# Find and consolidate all bucket declarations into single fitkarma-media
# Since buckets are declared in settings.buckets, we need to find them
# Actually looking at the structure, buckets are defined elsewhere in Appwrite
# The appwrite.json just configures the project

# Update tableDB indexes for share_tokens
for i, tbl in enumerate(data['tables']):
    if tbl.get('$id') == 'share_tokens':
        tbl['indexes'] = []

# Save
with open('appwrite.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=4)

print('Indexes added successfully!')