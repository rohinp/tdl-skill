# State Management

Persist state after meaningful interactions so learning can resume later.

## Files

- `learner-profile`: durable preferences, goals, strengths, struggles.
- `learning-state`: current domain, topic, stage, challenge, status, checkpoint.
- `progress`: mastery scores and evidence.
- `curiosity`: non-blocking questions and future exploration ideas.
- `concept-graph`: prerequisites, dependencies, branches, and mastery gates.
- `learning-branches`: deep dives and temporary learning branches.
- `revision-plan`: scheduled revision tasks.
- `resource-index`: learner-provided materials and trust level.
- `journey.md`: human-readable learning record, review artifact, and cross-agent resume handoff.

## Update Triggers

Update memory when:

- a learner completes or revises an attempt;
- a misconception is found;
- a hint is used;
- confidence changes;
- a curiosity question appears;
- a deep dive starts, pauses, or completes;
- a revision task is assigned or completed;
- a new resource is added.
- a session summary, explanation, or resume point should be preserved for the learner.

## Status Values

- `ACTIVE`: learner is on the primary path.
- `PAUSED`: session stopped and can resume.
- `COMPLETED`: path or branch is complete.
- `DEEP_DIVE`: learner is inside a temporary branch.
- `RETURN_PENDING`: branch is complete and the agent must restore the checkpoint.

## Minimum Resume Context

To resume cleanly, keep:

- current topic;
- current exercise or challenge;
- last learner attempt;
- last feedback;
- next recommended action;
- open blockers;
- active branch ID if in a deep dive.

## Journey Book Sync

Keep `.tdl-skill/journey.md` synchronized with JSON state. JSON stores structured facts; the journey book stores readable context.

For each meaningful event, add or update:

- current position;
- challenge or question;
- learner attempt summary;
- feedback and misconception summary;
- concepts learned;
- progress or confidence changes;
- next action.

If JSON state and the journey book conflict, prefer the more recent timestamp and reconcile both files.
