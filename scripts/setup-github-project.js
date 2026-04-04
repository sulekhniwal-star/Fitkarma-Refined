#!/usr/bin/env node
/**
 * FitKarma — GitHub Project Setup Script
 * ────────────────────────────────────────────────────────────────────────────
 * Creates:
 *   • 27 label categories  (difficulty, security, phase-N, epic, new, etc.)
 *   • 1 Epic issue per Phase  (26 epics total)
 *   • 1 Child issue per sub-section  (### N.M blocks)
 *   • GitHub Projects v2 board with Phase + Difficulty custom fields
 *   • All issues added to the project automatically
 *
 * Prerequisites:
 *   • gh CLI ≥ 2.31  →  brew install gh  /  https://cli.github.com
 *   • gh auth login  (must have repo + project write scope)
 *   • Node.js 18+
 *   • Run from the root of your FitKarma repo  (or pass --todo <path>)
 *
 * Usage:
 *   node scripts/setup-github-project.js [options]
 *
 * Options:
 *   --repo   OWNER/REPO    GitHub repository  (auto-detected from git remote)
 *   --todo   PATH          Path to TODO.md    (default: TODO.md)
 *   --dry-run              Print what would happen — no API calls
 *   --skip-project         Create issues only; skip project board creation
 * ────────────────────────────────────────────────────────────────────────────
 */

'use strict';

const { execSync, spawnSync } = require('child_process');
const fs   = require('fs');
const os   = require('os');
const path = require('path');

// ─── Logging ─────────────────────────────────────────────────────────────────
const c = {
  reset: '\x1b[0m', bold: '\x1b[1m', dim: '\x1b[2m',
  red: '\x1b[31m', green: '\x1b[32m', yellow: '\x1b[33m',
  blue: '\x1b[34m', magenta: '\x1b[35m', cyan: '\x1b[36m',
};
const log  = (...a) => console.log(...a);
const ok   = (m) => log(`  ${c.green}✅${c.reset} ${m}`);
const skip = (m) => log(`  ${c.dim}⏭  ${m}${c.reset}`);
const info = (m) => log(`  ${c.cyan}ℹ  ${m}${c.reset}`);
const warn = (m) => log(`  ${c.yellow}⚠  ${m}${c.reset}`);
const err  = (m) => log(`  ${c.red}❌ ${m}${c.reset}`);
const die  = (m) => { err(m); process.exit(1); };
const head = (m) => log(`\n${c.bold}${c.magenta}${m}${c.reset}`);

// ─── Shell Helpers ───────────────────────────────────────────────────────────
function run(cmd, opts = {}) {
  if (DRY_RUN && !opts.allowInDryRun) {
    log(`  ${c.dim}[DRY]${c.reset} ${cmd}`);
    return opts.dryReturn ?? '';
  }
  const result = spawnSync(cmd, { shell: true, encoding: 'utf8' });
  if (result.status !== 0 && !opts.ignoreError) {
    const msg = (result.stderr || result.stdout || '').trim();
    if (opts.throwOnError ?? true) throw new Error(msg || `exit ${result.status}`);
  }
  return (result.stdout || '').trim();
}

function gh(cmd, opts = {}) {
  return run(`gh ${cmd}`, opts);
}

function ghJSON(cmd, opts = {}) {
  try {
    const out = gh(cmd, { ...opts, dryReturn: '[]' });
    if (!out) return opts.fallback ?? null;
    return JSON.parse(out);
  } catch {
    return opts.fallback ?? null;
  }
}

const sleep = (ms) => new Promise(r => setTimeout(r, ms));

async function withTempFile(content, fn) {
  const tmpPath = path.join(os.tmpdir(), `fk_${Date.now()}_${Math.random().toString(36).slice(2)}.md`);
  fs.writeFileSync(tmpPath, content, 'utf8');
  try { return await fn(tmpPath); }
  finally { try { fs.unlinkSync(tmpPath); } catch {} }
}

// ─── Argument Parsing ───────────────────────────────────────────────────────
const argv     = process.argv.slice(2);
const flag     = (f) => { const i = argv.indexOf(f); return i !== -1 ? argv[i + 1] : null; };
const hasFlag  = (f) => argv.includes(f);

const DRY_RUN      = hasFlag('--dry-run');
const SKIP_PROJECT = hasFlag('--skip-project');
const TODO_FILE    = flag('--todo') || 'TODO.md';

// Auto-detect repo from git remote if not supplied
let REPO = flag('--repo');
if (!REPO) {
  try {
    const remote = run('git remote get-url origin');
    const m = remote.match(/github\.com[:/](.+?)(?:\.git)?$/);
    if (m) REPO = m[1];
  } catch { /* handled below */ }
}

if (!REPO) {
  die('Could not detect GitHub repo.\nPass --repo OWNER/REPO or run from inside your git repository.');
}

const [GH_OWNER, GH_REPO_NAME] = REPO.split('/');
const PROJECT_TITLE = 'FitKarma Development';
const DELAY_MS = 350; // polite rate-limiting between gh calls

// ─── Label Definitions ───────────────────────────────────────────────────────
function phaseColor(i) {
  // Rotating palette so adjacent phases are distinguishable
  const palette = [
    'E4E669','F9D0C4','FEF2C0','C2E0C6','BFD4F2','D4C5F9','C5DEF5',
    'EDEDED','F0FFF4','FFF0F3','F0F4FF','FFFDE7','F3E5F5','E8F5E9',
  ];
  return palette[i % palette.length];
}

const LABELS = [
  // Type labels
  { name: 'epic',               color: '7B2D8B', description: 'Phase-level epic issue'                      },
  { name: 'child-issue',        color: 'C5DEF5', description: 'Sub-section task linked to an epic'          },
  // Difficulty
  { name: 'difficulty: easy',   color: '0E8A16', description: '🟢 Beginner-friendly'                        },
  { name: 'difficulty: medium', color: 'FBCA04', description: '🟡 Moderate complexity'                      },
  { name: 'difficulty: hard',   color: 'D93F0B', description: '🔴 Complex implementation'                   },
  // Special
  { name: 'security',           color: 'B60205', description: '🔒 Security-critical — must not be skipped'  },
  { name: 'new',                color: '0075CA', description: '🆕 Added from architecture/feature review'   },
  { name: 'do-first',           color: 'E99695', description: '⚡ Do this first in the phase'              },
  { name: 'completed',          color: '6F42C1', description: 'Task already marked done in TODO.md'         },
  // Phase labels (0–26)
  ...Array.from({ length: 27 }, (_, i) => ({
    name: `phase-${i}`,
    color: phaseColor(i),
    description: `Belongs to Phase ${i}`,
  })),
];

// ─── TODO.md Parser ───────────────────────────────────────────────────────────
/**
 * Parses the FitKarma TODO.md and returns an array of Phase objects:
 *
 * Phase {
 *   number:      number
 *   title:       string
 *   description: string          (blockquote text after the ## heading)
 *   sections:    Section[]       (### sub-sections)
 *   looseTasks:  Task[]          (tasks not inside any ### sub-section)
 * }
 *
 * Section {
 *   id:       string   e.g. "1.2"
 *   title:    string
 *   tasks:    Task[]
 *   rawLines: string[] (original markdown lines for the issue body)
 * }
 *
 * Task {
 *   text:       string
 *   done:       boolean
 *   difficulty: 'easy' | 'medium' | 'hard'
 *   isSecurity: boolean
 *   isNew:      boolean
 *   isFirst:    boolean
 * }
 */
function parseTodo(content) {
  const lines   = content.split('\n');
  const phases  = [];
  let curPhase  = null;
  let curSec    = null;

  for (const line of lines) {
    // ── Phase header ──────────────────────────────────────────────────────
    const phaseMatch = line.match(/^## Phase (\d+)\s*[—–-]\s*(.+)/);
    if (phaseMatch) {
      curPhase = {
        number:      parseInt(phaseMatch[1], 10),
        title:       phaseMatch[2].trim(),
        description: '',
        sections:    [],
        looseTasks:  [],
      };
      phases.push(curPhase);
      curSec = null;
      continue;
    }

    if (!curPhase) continue;

    // ── Phase blockquote description ──────────────────────────────────────
    if (line.startsWith('>') && curPhase.sections.length === 0 && !curSec && curPhase.looseTasks.length === 0) {
      curPhase.description += line.replace(/^>\s*/, '').trim() + ' ';
      continue;
    }

    // ── Sub-section header ────────────────────────────────────────────────
    const secMatch = line.match(/^### (\d+\.\d+)\s+(.+)/);
    if (secMatch) {
      curSec = {
        id:       secMatch[1],
        title:    secMatch[2].trim(),
        tasks:    [],
        rawLines: [],
      };
      curPhase.sections.push(curSec);
      continue;
    }

    // ── Task line ─────────────────────────────────────────────────────────
    const taskMatch = line.match(/^(\s*)- \[([ xX])\] (.+)/);
    if (taskMatch) {
      const text = taskMatch[3];
      const task = {
        text,
        done:       taskMatch[2].toLowerCase() === 'x',
        difficulty: text.includes('🔴') ? 'hard'
                    : text.includes('🟡') ? 'medium'
                    : 'easy',
        isSecurity: text.includes('🔒'),
        isNew:      text.includes('🆕'),
        isFirst:    text.includes('⚡'),
      };

      if (curSec) {
        curSec.tasks.push(task);
        curSec.rawLines.push(line);
      } else {
        curPhase.looseTasks.push(task);
        // also keep raw line for the epic body
        if (!curPhase._looseRaw) curPhase._looseRaw = [];
        curPhase._looseRaw.push(line);
      }
      continue;
    }

    // ── Other lines inside a section (sub-task indents, code blocks) ──────
    if (curSec && line.trim()) {
      curSec.rawLines.push(line);
    }
  }

  return phases;
}

// ─── Difficulty heuristic for a whole section ─────────────────────────────────
function sectionDifficulty(section) {
  if (section.tasks.some(t => t.difficulty === 'hard'))   return 'difficulty: hard';
  if (section.tasks.some(t => t.difficulty === 'medium')) return 'difficulty: medium';
  return 'difficulty: easy';
}

// ─── Issue body builders ──────────────────────────────────────────────────────
function buildEpicBody(phase, childIssueRefs) {
  const childList = childIssueRefs.length
    ? childIssueRefs.map(c => `- [ ] #${c.number} **${c.title}**`).join('\n')
    : '_No sub-sections — tasks listed below._';

  const looseTasks = (phase._looseRaw || []).join('\n');

  return [
    `## 📦 Phase ${phase.number} — ${phase.title}`,
    '',
    phase.description.trim() ? `> ${phase.description.trim()}` : '',
    '',
    '---',
    '',
    '## 🔗 Child Issues',
    childList,
    '',
    looseTasks ? '## ✅ Tasks (no sub-section)' : '',
    looseTasks,
    '',
    '---',
    '_Auto-generated by `scripts/setup-github-project.js`_',
  ].filter(l => l !== undefined).join('\n').trim();
}

function buildChildBody(section, epicNumber, phase) {
  const tasks   = section.rawLines.join('\n');
  const hasDone = section.tasks.some(t => t.done);

  return [
    `> **Epic:** #${epicNumber} — Phase ${phase.number}: ${phase.title}`,
    '',
    `## ${section.id} ${section.title}`,
    '',
    tasks,
    '',
    hasDone ? '_Some tasks already completed in TODO.md (marked `[x]`)._' : '',
    '',
    '---',
    '_Auto-generated by `scripts/setup-github-project.js`_',
  ].filter(l => l !== undefined).join('\n').trim();
}

// ─── GitHub helpers ───────────────────────────────────────────────────────────
/** Fetch existing label names for this repo */
function fetchExistingLabels() {
  const labels = ghJSON(
    `label list --repo ${REPO} --json name --limit 200`,
    { fallback: [] }
  );
  return new Set((labels || []).map(l => l.name));
}

/** Create a label, skip gracefully if it already exists */
async function ensureLabel(label, existingSet) {
  if (existingSet.has(label.name)) {
    skip(`Label exists: ${label.name}`);
    return;
  }
  gh(
    `label create ${JSON.stringify(label.name)} --repo ${REPO}` +
    ` --color "${label.color}" --description ${JSON.stringify(label.description)}`,
    { ignoreError: true }
  );
  ok(`Created label: ${label.name}`);
  await sleep(DELAY_MS);
}

/** Create a GitHub issue and return its number */
async function createIssue({ title, labels, body }) {
  const labelStr = labels.join(',');
  let issueNumber = null;

  await withTempFile(body, async (tmpPath) => {
    const url = gh(
      `issue create --repo ${REPO}` +
      ` --title ${JSON.stringify(title)}` +
      ` --label "${labelStr}"` +
      ` --body-file "${tmpPath}"`,
      { dryReturn: `https://github.com/${REPO}/issues/0` }
    );
    // Extract number from URL: https://github.com/owner/repo/issues/123
    const m = (url || '').match(/\/issues\/(\d+)$/);
    issueNumber = m ? parseInt(m[1], 10) : null;
  });

  await sleep(DELAY_MS);
  return issueNumber;
}

/** Update an existing issue's body */
async function updateIssueBody(number, body) {
  await withTempFile(body, async (tmpPath) => {
    gh(`issue edit ${number} --repo ${REPO} --body-file "${tmpPath}"`, { ignoreError: true });
  });
  await sleep(DELAY_MS);
}

/** Find or create the GitHub Project v2, return its number */
function ensureProject() {
  const projectsJSON = gh(
    `project list --owner ${GH_OWNER} --format json --limit 50`,
    { ignoreError: true, dryReturn: '{"projects":[]}' }
  );
  let projects = [];
  try { projects = JSON.parse(projectsJSON || '{}').projects || []; } catch {}

  const existing = projects.find(p => p.title === PROJECT_TITLE);
  if (existing) {
    skip(`Project exists: "${PROJECT_TITLE}" (#${existing.number})`);
    return existing.number;
  }

  const created = gh(
    `project create --owner ${GH_OWNER} --title ${JSON.stringify(PROJECT_TITLE)} --format json`,
    { dryReturn: '{"number":1}' }
  );
  let num = null;
  try { num = JSON.parse(created || '{}').number; } catch {}
  ok(`Created project: "${PROJECT_TITLE}" (#${num})`);
  return num;
}

/** Add custom fields to the project (idempotent — gh ignores duplicate creates) */
function addProjectFields(projectNumber) {
  const base = `project field-create ${projectNumber} --owner ${GH_OWNER}`;
  gh(`${base} --name "Phase"      --data-type NUMBER`,       { ignoreError: true });
  gh(`${base} --name "Difficulty" --data-type SINGLE_SELECT --single-select-options "Easy,Medium,Hard"`, { ignoreError: true });
  gh(`${base} --name "Security"   --data-type SINGLE_SELECT --single-select-options "Yes,No"`,           { ignoreError: true });
  ok('Project custom fields set (Phase, Difficulty, Security)');
}

/** Add an issue to the project board */
async function addToProject(projectNumber, issueNumber) {
  gh(
    `project item-add ${projectNumber} --owner ${GH_OWNER}` +
    ` --url https://github.com/${REPO}/issues/${issueNumber}`,
    { ignoreError: true }
  );
  await sleep(150);
}

// ─── MAIN ────────────────────────────────────────────────────────────────────
async function main() {
  log(`\n${c.bold}${c.cyan}╔══════════════════════════════════════════════╗`);
  log(`║   FitKarma — GitHub Project Setup Script    ║`);
  log(`╚══════════════════════════════════════════════╝${c.reset}`);
  log(`\n  Repo:    ${c.bold}${REPO}${c.reset}`);
  log(`  TODO:    ${c.bold}${TODO_FILE}${c.reset}`);
  log(`  DryRun:  ${c.bold}${DRY_RUN}${c.reset}\n`);

  // ── Verify gh is available ──────────────────────────────────────────────
  try {
    run('gh --version', { allowInDryRun: true });
  } catch {
    die('gh CLI not found. Install it from https://cli.github.com then run `gh auth login`.');
  }

  // ── Read + parse TODO ───────────────────────────────────────────────────
  if (!fs.existsSync(TODO_FILE)) die(`TODO file not found: ${TODO_FILE}`);
  const content = fs.readFileSync(TODO_FILE, 'utf8');
  const phases  = parseTodo(content);
  log(`  Parsed ${c.bold}${phases.length} phases${c.reset} from ${TODO_FILE}`);

  const totalSections = phases.reduce((n, p) => n + p.sections.length, 0);
  log(`  Found  ${c.bold}${totalSections} sub-sections${c.reset} → child issues`);

  // ── Step 1: Labels ───────────────────────────────────────────────────────
  head('Step 1 — Labels');
  const existingLabels = fetchExistingLabels();
  for (const label of LABELS) {
    await ensureLabel(label, existingLabels);
  }

  // ── Step 2: GitHub Project ───────────────────────────────────────────────
  let projectNumber = null;
  if (!SKIP_PROJECT) {
    head('Step 2 — GitHub Project v2');
    projectNumber = ensureProject();
    if (projectNumber) addProjectFields(projectNumber);
  } else {
    info('Skipping project board creation (--skip-project)');
  }

  // ── Step 3: Issues ───────────────────────────────────────────────────────
  head('Step 3 — Issues');

  const stats = { epics: 0, children: 0, errors: 0 };

  for (const phase of phases) {
    log(`\n${c.bold}📦 Phase ${phase.number}${c.reset} — ${phase.title}`);

    // ── Child issues (sub-sections) ────────────────────────────────────────
    const childRefs = []; // { number, title }

    for (const section of phase.sections) {
      const labels = [
        'child-issue',
        `phase-${phase.number}`,
        sectionDifficulty(section),
        ...(section.tasks.some(t => t.isSecurity) ? ['security']  : []),
        ...(section.tasks.some(t => t.isNew)      ? ['new']       : []),
        ...(section.tasks.some(t => t.isFirst)    ? ['do-first']  : []),
        ...(section.tasks.every(t => t.done)      ? ['completed'] : []),
      ];

      // Placeholder body — will be updated with epic # after epic is created
      const placeholderBody = buildChildBody(section, '?', phase);
      const issueTitle      = `[P${phase.number}.${section.id.split('.')[1]}] ${section.title}`;

      try {
        const num = await createIssue({ title: issueTitle, labels, body: placeholderBody });
        if (num) {
          childRefs.push({ number: num, title: section.title, sectionId: section.id });
          log(`   ${c.dim}↳${c.reset} #${num}  ${section.id} ${section.title}`);
          stats.children++;

          if (projectNumber) await addToProject(projectNumber, num);
        }
      } catch (e) {
        warn(`Failed to create child issue for ${section.id}: ${e.message}`);
        stats.errors++;
      }
    }

    // ── Epic issue ──────────────────────────────────────────────────────────
    const epicLabels = [
      'epic',
      `phase-${phase.number}`,
      ...(phase.looseTasks.some(t => t.isSecurity) ? ['security'] : []),
      ...(phase.looseTasks.some(t => t.isNew)      ? ['new']      : []),
    ];

    const epicTitle = `[Epic] Phase ${phase.number} — ${phase.title}`;
    const epicBody  = buildEpicBody(phase, childRefs);

    let epicNumber = null;
    try {
      epicNumber = await createIssue({ title: epicTitle, labels: epicLabels, body: epicBody });
      if (epicNumber) {
        ok(`Epic #${epicNumber} created`);
        stats.epics++;
        if (projectNumber) await addToProject(projectNumber, epicNumber);
      }
    } catch (e) {
      warn(`Failed to create epic for Phase ${phase.number}: ${e.message}`);
      stats.errors++;
    }

    // ── Back-fill epic number into child issue bodies ──────────────────────
    if (epicNumber) {
      for (const child of childRefs) {
        const section = phase.sections.find(s => s.id === child.sectionId);
        if (!section) continue;
        const updatedBody = buildChildBody(section, epicNumber, phase);
        try {
          await updateIssueBody(child.number, updatedBody);
          log(`   ${c.dim}↳${c.reset} #${child.number} updated with epic ref`);
        } catch (e) {
          warn(`Could not update child #${child.number}: ${e.message}`);
        }
      }
    }
  }

  // ── Summary ─────────────────────────────────────────────────────────────
  head('Done! 🎉');
  log(`  Epics created:         ${c.bold}${stats.epics}${c.reset}`);
  log(`  Child issues created:  ${c.bold}${stats.children}${c.reset}`);
  if (stats.errors) log(`  Errors:                ${c.bold}${c.red}${stats.errors}${c.reset}`);
  log('');

  if (projectNumber) {
    log(`  Project board:  ${c.cyan}https://github.com/orgs/${GH_OWNER}/projects/${projectNumber}${c.reset}`);
  }
  log(`  Issues list:    ${c.cyan}https://github.com/${REPO}/issues${c.reset}`);
  log('');
}

main().catch(e => die(e.message));
