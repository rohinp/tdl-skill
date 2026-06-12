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
        ├── learning-branches.json
        ├── learning-state.json
        ├── progress.json
        ├── resource-index.json
        └── revision-plan.json
```

## Agent Modes

- `--agent claude`: writes `CLAUDE.md`.
- `--agent codex`: writes `AGENTS.md`.
- `--agent generic`: writes `TDL_PROMPT.md`.
- `--agent all`: writes all three.

`codex.sh` is a convenience wrapper for `claude.sh --agent codex`.

## Updating An Existing Install

By default, the installer preserves existing `.tdl-skill/framework` files. To replace them:

```bash
./claude.sh /path/to/my-learning-project --domain "Python" --force
```

Existing learner state is also preserved by default. With `--force`, framework files and state are reinitialized, so copy or commit existing state before using it on an active learning project.
