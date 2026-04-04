# FitKarma — GitHub Project Setup

Automates the full GitHub project scaffolding from `TODO.md`:

| What it creates | Count |
|---|---|
| Label categories | 27+ (difficulty, phase-N, security, epic, new…) |
| Epic issues | 1 per Phase (`## Phase N`) |
| Child issues | 1 per sub-section (`### N.M`) |
| GitHub Project v2 board | 1 board with custom fields |

---

## Prerequisites

```bash
# 1. Install gh CLI (≥ 2.31)
brew install gh           # macOS
# or: https://cli.github.com/

# 2. Authenticate with repo + project write scope
gh auth login
gh auth refresh -s project   # needed for Projects v2 write access

# 3. Node.js 18+
node --version
```

---

## Usage

```bash
# From your FitKarma repo root (auto-detects repo from git remote):
node scripts/setup-github-project.js

# Explicit options:
node scripts/setup-github-project.js \
  --repo  YOUR_USERNAME/fitkarma \
  --todo  TODO.md

# Preview what will happen — no API calls made:
node scripts/setup-github-project.js --dry-run

# Issues only (skip project board creation):
node scripts/setup-github-project.js --skip-project
```

---

## What gets created

### Labels
| Label | Colour | Purpose |
|---|---|---|
| `epic` | purple | Phase-level tracking issue |
| `child-issue` | blue | Sub-section issue linked to epic |
| `difficulty: easy` | green | 🟢 tasks |
| `difficulty: medium` | yellow | 🟡 tasks |
| `difficulty: hard` | red | 🔴 tasks |
| `security` | dark red | 🔒 security-critical |
| `new` | blue | 🆕 from architecture review |
| `do-first` | pink | ⚡ first priority in phase |
| `completed` | purple | Already done in TODO.md |
| `phase-0` … `phase-26` | rotating | Phase membership |

### Issue hierarchy
```
[Epic] Phase 3 — Core Infrastructure          ← Epic issue
  ├── [P3.1] Appwrite Client                  ← Child issue
  ├── [P3.2] Local Storage — Drift (SQLCipher)
  ├── [P3.3] Encryption Service
  ├── [P3.4] Connectivity & Sync Queue
  ├── [P3.5] Background Sync
  ├── [P3.6] Error Handling
  ├── [P3.7] Appwrite Permissions
  └── [P3.8] Riverpod Provider Architecture
```

Each child issue:
- Contains all checkboxes from that sub-section
- Links back to its parent epic with `#N`
- Carries the correct difficulty / security / new labels

### Project Board
- **Board name:** `FitKarma Development`
- **Custom fields:** `Phase` (number), `Difficulty` (select), `Security` (select)
- All epics and child issues are added to the board automatically

---

## Re-running safely

- Labels: idempotent — existing labels are skipped
- Project: idempotent — existing project is reused
- Issues: **not** idempotent — running twice will create duplicate issues.  
  If you need to re-run, close/delete the previously created issues first,  
  or use `--skip-project` to only create missing issues.

---

## Troubleshooting

| Error | Fix |
|---|---|
| `gh: command not found` | Install gh CLI from https://cli.github.com |
| `HTTP 403 on project create` | Run `gh auth refresh -s project` |
| `Could not detect GitHub repo` | Pass `--repo OWNER/REPO` explicitly |
| Rate limit / 429 errors | Increase `DELAY_MS` constant in the script |
| `field-create: unknown flag` | Update gh CLI to ≥ 2.31 |
