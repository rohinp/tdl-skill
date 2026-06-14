# Journey Book

The journey book is the learner-facing record of the entire apprenticeship. JSON state is optimized for machines; the journey book is optimized for humans and agent handoff.

Installed projects should keep it at:

```text
.tdl-skill/journey.md
```

## Purpose

Use the journey book to:

- review what the learner has already attempted;
- capture explanations that worked;
- preserve mistakes, misconceptions, and refinements;
- summarize deep dives and returns;
- make progress portable between agents;
- resume learning when JSON state is unavailable, incomplete, or stale.

## Update Rule

Update `.tdl-skill/journey.md` after every meaningful learning event:

- assessment answer;
- micro-challenge assigned;
- learner attempt;
- feedback;
- targeted explanation;
- refined answer;
- progress update;
- curiosity question;
- blocker or deep dive trigger;
- deep dive summary;
- revision task;
- project milestone;
- session pause or resume.

Keep entries concise. The journey book should be readable, not a raw chat transcript.

## Recommended Entry Format

```markdown
### YYYY-MM-DD HH:MM - <Topic>

Stage: <assessment | micro_challenge | attempt | feedback | refinement | deep_dive | revision | project>

Challenge:
<short prompt>

Learner attempt:
<summary or exact answer when useful>

Feedback:
- Strength:
- Mistake:
- Misconception:
- Hint used:

What changed:
- Progress:
- Confidence:
- State update:

Next action:
<one concrete next step>
```

## Resume From Journey Only

When an agent receives only `journey.md`, it should:

1. Read the `Current Position` and latest `Resume Brief`.
2. Infer current domain, topic, stage, challenge, known strengths, struggles, and next action.
3. Ask one clarifying question only if the next action is ambiguous.
4. Recreate or update `.tdl-skill/state/*.json` if file access is available.
5. Continue with the next micro-challenge, revision task, or checkpoint restoration.

## What Not To Store

Do not store secrets, API keys, private credentials, or sensitive personal data. Summarize private resources by title or local reference instead of copying confidential content into the journey book.
