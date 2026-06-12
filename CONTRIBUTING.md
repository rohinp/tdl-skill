# Contributing

TDL-Skill should stay small, reusable, and domain independent.

## Principles

- Keep the learning method separate from domain knowledge.
- Prefer examples that demonstrate behavior over long theory.
- Keep schemas simple enough for agents and humans to maintain.
- Do not optimize for course completion metrics.
- Add state fields only when they affect future teaching decisions.

## Adding A Domain Example

1. Create `examples/domains/<domain>/session.json`.
2. Include assessment, micro challenge, learner attempt, feedback, progress update, and next action.
3. Use the shared schemas where possible.
4. Keep domain facts concise and resource-grounded when resources are listed.

## Adding A Schema Field

1. Add the field to the relevant schema in `schemas/`.
2. Update the matching template in `templates/`.
3. Update at least one example.
4. Explain why the field changes future learning behavior.

## Validation

Run:

```bash
python3 scripts/validate_json.py templates examples memory
```
