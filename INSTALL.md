# Install TDL-Skill Into A Learning Project

You can use TDL-Skill in two ways:

1. Clone this repository and run the installer locally.
2. Run the installer directly from GitHub with `curl`.

The installer copies the relevant framework files into your target project under `.tdl-skill/`, initializes learner state, and creates an agent instruction file.

## Local Install

```bash
./claude.sh /path/to/my-learning-project
```

With a domain:

```bash
./claude.sh /path/to/my-learning-project --domain "Python"
```

For all supported agent instruction files:

```bash
./claude.sh /path/to/my-learning-project --domain "Neural Networks" --agent all
```

For Codex specifically:

```bash
./codex.sh /path/to/my-learning-project --domain "Python"
```

## Direct GitHub Install

After this repository is pushed to GitHub, use:

```bash
TDL_SKILL_REPO_URL="https://github.com/OWNER/tdl-skill" \
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/OWNER/tdl-skill/main/claude.sh)" -- /path/to/my-learning-project
```

Replace `OWNER` with the GitHub owner or organization.

You can also pass the domain:

```bash
TDL_SKILL_REPO_URL="https://github.com/OWNER/tdl-skill" \
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/OWNER/tdl-skill/main/claude.sh)" -- /path/to/my-learning-project --domain "Data Governance"
```

For Codex:

```bash
TDL_SKILL_REPO_URL="https://github.com/OWNER/tdl-skill" \
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/OWNER/tdl-skill/main/codex.sh)" -- /path/to/my-learning-project --domain "Python"
```

## What Gets Created

```text
my-learning-project/
├── CLAUDE.md
└── .tdl-skill/
    ├── journey.md
    ├── framework/
    │   ├── SKILL.md
    │   ├── documentation/
    │   ├── examples/
    │   ├── references/
    │   ├── schemas/
    │   ├── scripts/
    │   └── templates/
    └── state/
        ├── concept-graph.json
        ├── curiosity.json
        ├── learner-profile.json
        ├── learning-contract.json
        ├── learning-branches.json
        ├── learning-state.json
        ├── progress.json
        ├── resource-index.json
        └── revision-plan.json
```

The journey book is intentionally outside `state/` because it is a durable learner-facing artifact, not just machine state.

## Agent Modes

- `--agent claude`: writes `CLAUDE.md`.
- `--agent codex`: writes `AGENTS.md`.
- `--agent generic`: writes `TDL_PROMPT.md`.
- `--agent all`: writes all three.

`codex.sh` is a convenience wrapper for `claude.sh --agent codex`.

## After Install: Start Learning

Open the target project in your agent. If you use Claude Code and run `/init`, let it read the project first. Then start the learning loop with:

```text
Use the TDL-Skill framework in this repo.

My learning domain is <your domain>.

Start Phase 0 assessment now. Ask me only the minimum questions needed to understand what I want to learn, where I want to apply it, my starting level, what should count as finished, my available time, preferred learning style, and any resources I want to use.

After the assessment, give me one small micro-challenge before explaining anything.
```

After you answer the assessment questions, use:

```text
Based on my answers, update `.tdl-skill/state/learner-profile.json`, `.tdl-skill/state/learning-contract.json`, `.tdl-skill/state/learning-state.json`, and `.tdl-skill/journey.md`, then give me the first micro-challenge.
```

For example:

```text
Use TDL-Skill to teach me Python with genAI. My goal is to build practical Python apps that call LLM APIs, use prompts well, handle structured outputs, and eventually build small agent workflows.

Assess me first, then give one tiny challenge. Do not explain the topic before I attempt it.
```

The agent should continue updating `.tdl-skill/state/` and `.tdl-skill/journey.md` after attempts, feedback, blockers, curiosity questions, revision tasks, and deep dives.

## Updating An Existing Install

By default, the installer preserves existing `.tdl-skill/framework` files. To replace them:

```bash
./claude.sh /path/to/my-learning-project --domain "Python" --force
```

Existing learner state and journey book are also preserved by default. With `--force`, framework files, state, and journey book are reinitialized, so copy or commit existing learning artifacts before using it on an active learning project.
