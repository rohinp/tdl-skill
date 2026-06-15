# (Test Driven Learning) TDL-Skill

TDL-Skill is a reusable, agent-agnostic learning framework for turning an AI assistant into a long-term mentor. It is built around test driven learning: the learner attempts small tasks first, then the agent gives feedback, targeted explanation, revision, and progressively harder challenges.

The goal is mastery, not lesson completion.

## What This Repository Contains

- `SKILL.md`: the compact skill entry point for Codex-style skill loaders.
- `references/`: methodology guides that any AI agent can follow.
- `schemas/`: JSON Schemas for learner memory, learning state, concept graphs, progress, curiosity, resources, revision plans, and learning branches.
- `templates/`: blank JSON files an agent can copy to start a new learner.
- `templates/journey.template.md`: human-readable learning journey template.
- `memory/`: example persistent memory files.
- `examples/`: complete examples for Neural Networks, Python, Data Governance, resource-grounded sessions, deep dives, branching paths, and context restoration.
- `documentation/`: user-facing explanations for the learning graph, checkpoint system, deep dives, and extensibility.
- `scripts/validate_json.py`: lightweight JSON validation helper.
- `claude.sh`: project initializer for Claude, Codex, or generic agents.
- `codex.sh`: convenience wrapper that initializes Codex projects.

## Core Learning Loop

1. Assess the learner's current level, goals, time, preferences, and resources.
2. Create a learning contract with scope, application context, completion criteria, and a finish boundary.
3. Give a micro challenge before explaining the topic.
4. Ask the learner to attempt it independently.
5. Review the attempt for strengths, mistakes, misconceptions, and confidence.
6. Explain only what is needed to unblock the learner.
7. Let the learner refine the attempt.
8. Upgrade the challenge gradually.
9. Periodically run revision using learner history.
10. Finish when the contract is met, then propose next-step tracks.

The agent should prefer hints before explanations and explanations before full solutions.

## Quick Start For An AI Agent

1. Load [SKILL.md](SKILL.md).
2. Read [references/methodology.md](references/methodology.md) if you need the full mentor workflow.
3. Copy the JSON templates in [templates](templates) into a learner-specific storage location.
4. Ask the Phase 0 assessment questions.
5. Start with a tiny challenge.
6. Persist updates after every meaningful interaction.

Example first prompt:

```text
I will use TDL-Skill for Python. Assess my current level, then give me a tiny challenge before explaining anything.
```

For a fuller walkthrough, see [documentation/onboarding-guide.md](documentation/onboarding-guide.md).

## Install Into A Learning Project

Run the installer from this repository:

```bash
./claude.sh /path/to/my-learning-project --domain "Python"
```

For Claude it writes `CLAUDE.md`; for Codex use `--agent codex`; for a pasteable prompt use `--agent generic`.

Codex shortcut:

```bash
./codex.sh /path/to/my-learning-project --domain "Python"
```

After pushing this repo to GitHub, users can run it directly from the raw script. See [INSTALL.md](INSTALL.md).

After installation, open the target project in your agent and ask it to start Phase 0 assessment. The exact starter prompts are in [INSTALL.md](INSTALL.md#after-install-start-learning).

## Resource-Grounded Learning

Learner-provided materials are primary sources. The agent should use supplied books, PDFs, docs, slides, notes, links, videos, or internal documents before relying on general model knowledge.

When external knowledge is used, the agent must label it clearly as external context.

See [documentation/resource-grounded-deep-dives.md](documentation/resource-grounded-deep-dives.md).

## Persistence Model

TDL-Skill keeps separate JSON files for:

- Learner profile and preferences
- Learning contract and completion criteria
- Current learning state
- Progress and mastery scores
- Curiosity items
- Concept graph
- Learning branches and deep dives
- Revision plans
- Resource index
- Human-readable journey book

The files are intentionally simple so they can be stored in a repository, local folder, database, vector store metadata layer, or agent memory system.

Installed learning projects also include `.tdl-skill/journey.md`, a readable record of the learner's attempts, feedback, misconceptions, deep dives, progress, and next action. A learner can review it like a book, and another agent can use it to resume the journey if structured state is unavailable.

## Validate JSON Files

```bash
python3 scripts/validate_json.py templates examples memory
```

The helper checks that included JSON files are parseable. Full schema validation can be added by consumers with their preferred JSON Schema validator.

## Example Domains

- [Neural Networks](examples/domains/neural-networks/session.json)
- [Python](examples/domains/python/session.json)
- [Data Governance](examples/domains/data-governance/session.json)
- [Learning Contract](examples/learning-contracts/python-with-genai-contract.json)
- [Journey Book](examples/journey-books/python-with-genai-journey.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Roadmap

See [ROADMAP.md](ROADMAP.md).
