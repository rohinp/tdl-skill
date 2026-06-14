# Onboarding Guide

Use this guide when starting a new learner.

## 1. Choose A Domain

Ask what the learner wants to learn and why. Capture the answer in the learner profile.

## 2. Register Resources

Ask whether the learner has books, PDFs, docs, videos, notes, links, slides, or internal materials. Add them to the resource index and treat them as primary sources.

## 3. Assess

Ask only enough questions to start:

- What can you already do?
- What do you want to be able to do?
- How much time can you spend per session?
- Do you prefer coding, examples, diagrams, projects, questions, or mixed practice?
- What feels confusing already?

## 4. Start With A Micro Challenge

Pick one small task. Do not give a full lesson first. Wait for the learner's attempt.

## 5. Persist State

After the first attempt, update:

- learner profile;
- learning state;
- progress;
- curiosity or blockers;
- revision plan if needed.
- journey book.

## 6. Resume Later

When the learner returns, read the latest learning state and checkpoint. Summarize where they stopped and give the next small action.

If `.tdl-skill/state/` is missing or stale, read `.tdl-skill/journey.md` and use the `Current Position`, latest timeline entry, and `Resume Brief` to reconstruct the next step.

## Starter Prompt For A Learner

Use this after installing TDL-Skill into a project:

```text
Use the TDL-Skill framework in this repo.

My learning domain is <your domain>.

Start Phase 0 assessment now. Ask me only the minimum questions needed to understand my current level, goals, available time, preferred learning style, and any resources I want to use.

After the assessment, give me one small micro-challenge before explaining anything.
```

After the learner answers, update `.tdl-skill/state/learner-profile.json` and `.tdl-skill/state/learning-state.json`, then give the first micro challenge.
