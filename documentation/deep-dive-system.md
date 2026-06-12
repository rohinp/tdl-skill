# Deep Dive System

A deep dive is a temporary learning branch created when the learner needs deeper understanding before continuing the primary path.

## Trigger Conditions

Recommend a deep dive when the learner:

- repeats the same mistake;
- fails multiple attempts;
- reports low confidence;
- asks to go deeper;
- can perform a procedure but cannot explain why it works;
- is blocked by a prerequisite.

## Branch Types

- `concept`: understand a concept more deeply.
- `mathematical`: build mathematical foundations.
- `implementation`: understand how something is implemented.
- `visual`: build intuition through diagrams or visual reasoning.
- `historical`: understand origin and evolution.
- `resource`: explore a supplied resource in depth.

## Required Flow

1. Store a return checkpoint.
2. Create a learning branch linked to the parent topic.
3. Run the normal micro challenge and feedback loop inside the branch.
4. Mark the branch complete only after the learner demonstrates the branch objective.
5. Generate a summary, concepts learned, why they matter, and relationship to the original topic.
6. Restore the checkpoint and continue the original challenge.

## Completion Message Pattern

```text
Deep dive complete.

You learned: <concepts>.
These concepts matter because: <connection>.
Returning to: <topic>, <exercise>, <challenge>.
Next attempt: <specific action>.
```
