# TDL-Skill

TDL-Skill is a reusable, agent-agnostic learning framework for turning an AI assistant into a long-term mentor. It is built around test driven learning: the learner attempts small tasks first, then the agent gives feedback, targeted explanation, revision, and progressively harder challenges.

The goal is mastery, not lesson completion.

## What This Repository Contains

- `SKILL.md`: the compact skill entry point for Codex-style skill loaders.
- `references/`: methodology guides that any AI agent can follow.
- `schemas/`: JSON Schemas for learner memory, learning state, concept graphs, progress, curiosity, resources, revision plans, and learning branches.
- `templates/`: blank JSON files an agent can copy to start a new learner.
- `memory/`: example persistent memory files.
- `examples/`: complete examples for Neural Networks, Python, Data Governance, resource-grounded sessions, deep dives, branching paths, and context restoration.
- `documentation/`: user-facing explanations for the learning graph, checkpoint system, deep dives, and extensibility.
- `scripts/validate_json.py`: lightweight JSON validation helper.

## Core Learning Loop

1. Assess the learner's current level, goals, time, preferences, and resources.
2. Give a micro challenge before explaining the topic.
3. Ask the learner to attempt it independently.
4. Review the attempt for strengths, mistakes, misconceptions, and confidence.
5. Explain only what is needed to unblock the learner.
6. Let the learner refine the attempt.
7. Upgrade the challenge gradually.
8. Periodically run revision using learner history.

The agent should prefer hints before explanations and explanations before full solutions.

## Quick Start For An AI Agent

1. Load [SKILL.md](/Users/rohinpatel/Development/myprojects/tdl-skill/SKILL.md).
2. Read [references/methodology.md](/Users/rohinpatel/Development/myprojects/tdl-skill/references/methodology.md) if you need the full mentor workflow.
3. Copy the JSON templates in [templates](/Users/rohinpatel/Development/myprojects/tdl-skill/templates) into a learner-specific storage location.
4. Ask the Phase 0 assessment questions.
5. Start with a tiny challenge.
6. Persist updates after every meaningful interaction.

Example first prompt:

```text
I will use TDL-Skill for Python. Assess my current level, then give me a tiny challenge before explaining anything.
```

For a fuller walkthrough, see [documentation/onboarding-guide.md](/Users/rohinpatel/Development/myprojects/tdl-skill/documentation/onboarding-guide.md).

## Resource-Grounded Learning

Learner-provided materials are primary sources. The agent should use supplied books, PDFs, docs, slides, notes, links, videos, or internal documents before relying on general model knowledge.

When external knowledge is used, the agent must label it clearly as external context.

See [documentation/resource-grounded-deep-dives.md](/Users/rohinpatel/Development/myprojects/tdl-skill/documentation/resource-grounded-deep-dives.md).

## Persistence Model

TDL-Skill keeps separate JSON files for:

- Learner profile and preferences
- Current learning state
- Progress and mastery scores
- Curiosity items
- Concept graph
- Learning branches and deep dives
- Revision plans
- Resource index

The files are intentionally simple so they can be stored in a repository, local folder, database, vector store metadata layer, or agent memory system.

## Validate JSON Files

```bash
python3 scripts/validate_json.py templates examples memory
```

The helper checks that included JSON files are parseable. Full schema validation can be added by consumers with their preferred JSON Schema validator.

## Example Domains

- [Neural Networks](/Users/rohinpatel/Development/myprojects/tdl-skill/examples/domains/neural-networks/session.json)
- [Python](/Users/rohinpatel/Development/myprojects/tdl-skill/examples/domains/python/session.json)
- [Data Governance](/Users/rohinpatel/Development/myprojects/tdl-skill/examples/domains/data-governance/session.json)

## Contributing

See [CONTRIBUTING.md](/Users/rohinpatel/Development/myprojects/tdl-skill/CONTRIBUTING.md).

## Roadmap

See [ROADMAP.md](/Users/rohinpatel/Development/myprojects/tdl-skill/ROADMAP.md).
