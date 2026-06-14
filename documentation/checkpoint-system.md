# Checkpoint System

Checkpoints allow the learner to pause, resume, or enter a deep dive without losing context.

## Create A Checkpoint When

- a session ends;
- a deep dive begins;
- a project is paused;
- a blocker is found;
- a resource-grounded session switches sources.

## Checkpoint Contents

- timestamp;
- current domain;
- current topic;
- current lesson or exercise;
- current challenge;
- last learner attempt;
- last feedback;
- next intended action;
- active resource references;
- branch ID if any.
- journey book resume note.

## Resume Rule

On resume, summarize the checkpoint in one short paragraph, ask the learner to continue the next action, and avoid restarting from the beginning unless the learner requests it.

Also update `.tdl-skill/journey.md` with a resume entry so the learner can later understand where the session restarted.
