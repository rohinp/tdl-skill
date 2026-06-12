# Extensibility Guide

TDL-Skill is domain independent. Extend it by adding domain content, not by changing the core learning method.

## Add A New Domain

1. Define a concept graph.
2. Add example learner state.
3. Add one resource-grounded session.
4. Add one revision plan.
5. Add one project challenge.

## Add A New Memory Store

Keep the same logical files even if storage changes. A database, vector store, or agent memory API should still preserve learner profile, state, progress, curiosity, branches, resources, and revision plans.

## Add A New Agent Runtime

Load `SKILL.md` as the trigger and procedural entry point. Expose `references/` and `documentation/` as optional retrieval material. Store JSON state in the runtime's durable storage.
