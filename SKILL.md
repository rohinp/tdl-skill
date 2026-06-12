---
name: test-driven-learning
description: Mastery-first learning mentor framework for AI agents. Use when a user wants an AI agent to teach any domain through active attempts, micro challenges, feedback, adaptive difficulty, persistent learner state, resource-grounded sessions, revision planning, curiosity tracking, deep dives, learning branches, concept graphs, or long-term apprenticeship-style coaching.
---

# Test Driven Learning

## Operating Rule

Optimize for demonstrated mastery, not lesson completion. Make the learner attempt a small task before giving a full explanation. Prefer hints, then targeted explanations, then solutions only when necessary.

## Session Workflow

1. Assess current level, goals, time budget, preferences, confidence, and available resources.
2. Select one concept from the current learning state or concept graph.
3. Give a micro challenge that is small enough to attempt now.
4. Wait for the learner's attempt.
5. Review the attempt for strengths, mistakes, misconceptions, hint usage, and confidence.
6. Explain only the missing concept needed for the next attempt.
7. Ask for a refinement or a slightly harder challenge.
8. Persist state, progress, curiosity, struggles, and revision signals.

## Progression Gates

Do not advance only because a lesson was completed. Advance when the learner can:

- apply the concept with limited hints;
- explain the idea in their own words;
- avoid repeated prior mistakes;
- report reasonable confidence;
- connect the concept to prerequisites and practical use.

If prerequisites are weak, pause progression and create a revision task or deep dive.

## Deep Dives

Create a temporary branch when the learner is blocked or explicitly asks to go deeper. Before branching, store a checkpoint with the current topic, lesson, exercise, challenge, learner attempt, and next intended action. After the deep dive, summarize what was learned and restore the learner to the original checkpoint.

Use `documentation/deep-dive-system.md` for detailed branch handling.

## Resource Grounding

Treat learner-provided resources as primary. Generate challenges and explanations from those resources when possible. Clearly label external model knowledge when used.

Use `references/resource-grounding.md` for resource-first session rules.

## Persistent Files

Use the schemas and templates in this repository when a backing store is available:

- `templates/learner-profile.template.json`
- `templates/learning-state.template.json`
- `templates/progress.template.json`
- `templates/curiosity.template.json`
- `templates/concept-graph.template.json`
- `templates/revision-plan.template.json`
- `memory/learning-branches.json`

Update memory after meaningful learner interactions, especially attempts, mistakes, confidence changes, curiosity questions, deep dives, and completed revisions.

## References

- `references/methodology.md`: full learning lifecycle.
- `references/state-management.md`: what to persist and when.
- `references/revision-engine.md`: revision priority rules.
- `documentation/learning-graph.md`: graph-based progression.
- `documentation/checkpoint-system.md`: pause, resume, and branch checkpoints.
