# Learning Contract

The learning contract defines the boundary of a learning journey. It tells the agent what the learner wants to learn, where they want to apply it, where they are starting, what is in scope, and when the journey should be considered complete.

Without a contract, the agent can keep teaching indefinitely. With a contract, the agent behaves like a good teacher: it knows what to cover, what to skip, when to slow down, when to finish, and what next steps to propose.

Installed projects should keep it at:

```text
.tdl-skill/state/learning-contract.json
```

## Required Onboarding Questions

During Phase 0, collect enough information to draft the contract:

1. What do you want to learn?
2. Where do you want to apply it?
3. What is your starting level?
4. What should you be able to do when this learning journey is finished?
5. What is not important for now?
6. How much time can you spend?

Do not over-question. Ask follow-ups only when the scope is ambiguous.

## Scope Fields

- `domain`: the skill or subject, such as Python, Dutch, Data Governance, or Neural Networks.
- `application_context`: where the learner wants to use it, such as work, a project, an exam, a job interview, or personal curiosity.
- `start_level`: absolute beginner, beginner, intermediate, advanced, or unknown.
- `target_outcome`: the practical ability the learner wants.
- `in_scope`: concepts and abilities this journey should cover.
- `out_of_scope`: tempting but unnecessary topics to avoid for now.
- `completion_criteria`: observable evidence that the learner is ready to finish.
- `capstone`: practical final task that combines the core concepts.

## Finish Rule

The journey is complete when:

- required completion criteria are met;
- weak prerequisite concepts have been revised;
- the learner can complete the capstone or agreed equivalent;
- the learner can explain the key ideas in their own words;
- the journey book contains a final summary and next-step options.

When the contract is complete, stop pretending there is another required lesson. Instead:

1. summarize what the learner can now do;
2. list remaining optional weak spots;
3. mark the contract as complete;
4. propose next-step tracks, such as deeper specialization, a new project, revision-only mode, or a broader follow-up journey.

The learner can always extend the contract, but extension should be explicit.

## Example

```json
{
  "domain": "Python with genAI",
  "start_level": "beginner",
  "target_outcome": "Build a small Python app that calls an LLM API and validates structured output.",
  "application_context": "Personal projects and work automation",
  "scope": {
    "in_scope": [
      "Python functions",
      "HTTP/API basics",
      "prompt inputs",
      "structured JSON output",
      "basic validation",
      "error handling"
    ],
    "out_of_scope": [
      "Training models",
      "Vector databases",
      "Production deployment"
    ],
    "assumptions": [
      "Learner can install packages with guidance."
    ]
  }
}
```
