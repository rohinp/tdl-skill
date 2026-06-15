# Learning Journey

Domain: Python with genAI
Learner: example-learner
Started: 2026-01-10T09:00:00Z

This is a shortened example of a journey book. It is not a raw transcript; it is a readable record of attempts, feedback, concepts, and next actions.

## Current Position

- Current domain: Python with genAI
- Current topic: Calling an LLM API safely
- Current stage: refinement
- Current challenge: Write a function that accepts a user question and returns a structured JSON response.
- Next action: Refine the function to validate missing fields before returning.

## Learner Profile Summary

- Goals:
  - Build practical Python apps that call LLM APIs.
  - Use prompts, structured outputs, and small agent workflows.
- Preferred learning style: small coding tasks, feedback, then targeted explanation.
- Known strengths:
  - Basic Python functions.
  - Reading simple JSON.
- Known struggle areas:
  - Handling malformed model output.
  - Separating prompt design from application validation.

## Learning Contract

- Domain: Python with genAI
- Starting level: beginner
- Application context: personal productivity projects and work automation prototypes.
- Target outcome: build a small Python app that calls an LLM API, validates structured JSON output, and handles basic errors.
- In scope:
  - Python functions
  - Dictionaries and JSON
  - Calling an LLM API from Python
  - Prompt inputs
  - Structured output validation
  - Basic error handling
- Out of scope:
  - Fine-tuning
  - Vector databases
  - Production deployment
  - Complex multi-agent orchestration
- Completion criteria:
  - Explain prompt instructions versus application-side validation.
  - Validate required fields in a model response.
  - Build a tiny command-line app with a basic error path.
- Capstone or final evidence:
  - Tiny Python CLI that asks a question, calls an LLM, validates the response, and prints a friendly result.

## Timeline

### 2026-01-10 09:00 - Assessment

Stage: assessment

Learner goal:
Build small Python applications that use LLM APIs and structured outputs.

Agent decision:
Start with a tiny function before explaining API architecture.

Next action:
Give a micro-challenge about validating structured output.

### 2026-01-10 09:12 - Structured Output Micro-Challenge

Stage: feedback

Challenge:
Write a Python function that checks whether a model response contains `answer` and `confidence`.

Learner attempt:
Checked only whether `answer` exists.

Feedback:
- Strength: used a simple function and returned a boolean.
- Mistake: missed the `confidence` field.
- Misconception: assumed model output is trustworthy if the main text exists.

Targeted explanation:
Structured output still needs application-side validation because models can omit fields, produce wrong types, or return partial data.

What changed:
- Progress: structured output validation introduced.
- Confidence: medium.
- State update: add "schema validation" as a weak area.

Next action:
Refine the function to check both required fields and confirm `confidence` is numeric.

## Concept Progress

- Python functions: strong evidence from attempts.
- JSON/dict validation: developing.
- Structured LLM outputs: early stage.

## Curiosity And Open Questions

- How do libraries force JSON schema output?
- What is the difference between prompt formatting and actual validation?

## Mistakes And Misconceptions

- Treating model output as reliable without validation.
- Checking for one required key but not the whole expected structure.

## Deep Dives

No deep dives completed yet.

## Revision Log

- Revisit dict key validation after the next challenge.

## Resume Brief

Continue with the structured output validation refinement. Ask the learner to update the function so it checks `answer`, `confidence`, and the type of `confidence`. Do not explain schema libraries yet unless the learner asks or gets blocked.
