#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "$0")"
DEFAULT_REPO_URL="${TDL_SKILL_REPO_URL:-}"
DEFAULT_BRANCH="${TDL_SKILL_BRANCH:-main}"
TDL_TMP_ROOT=""

cleanup() {
  if [ -n "$TDL_TMP_ROOT" ] && [ -d "$TDL_TMP_ROOT" ]; then
    rm -rf "$TDL_TMP_ROOT"
  fi
}

trap cleanup EXIT

usage() {
  cat <<'USAGE'
Usage:
  ./claude.sh path/to/project
  ./claude.sh path/to/project --domain "Python"
  ./claude.sh path/to/project --agent claude

Options:
  --domain NAME       Learning domain or skill to initialize.
  --agent NAME        claude, codex, generic, or all. Default: claude.
  --force             Replace existing .tdl-skill framework, state, and journey files.
  -h, --help          Show help.

Remote usage:
  TDL_SKILL_REPO_URL="https://github.com/OWNER/tdl-skill" \
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/OWNER/tdl-skill/main/claude.sh)" -- path/to/project

The script copies the TDL framework into the target project and initializes
project-local learner state under .tdl-skill/state plus .tdl-skill/journey.md.
USAGE
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

info() {
  printf '%s\n' "$*"
}

json_escape() {
  python3 -c 'import json,sys; print(json.dumps(sys.stdin.read().rstrip("\n")))' 2>/dev/null || {
    sed 's/\\/\\\\/g; s/"/\\"/g' | awk '{ printf "\"%s\"", $0 }'
  }
}

now_utc() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed 's/[^a-z0-9][^a-z0-9]*/-/g; s/^-//; s/-$//'
}

copy_dir() {
  src="$1"
  dst="$2"
  force="$3"

  [ -d "$src" ] || return 0

  if [ -e "$dst" ] && [ "$force" != "true" ]; then
    info "Keeping existing $dst"
    return 0
  fi

  rm -rf "$dst"
  mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
}

resolve_source_dir() {
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd -P || pwd)"

  if [ -f "$script_dir/SKILL.md" ] && [ -d "$script_dir/references" ]; then
    printf '%s\n' "$script_dir"
    return 0
  fi

  if [ -f "./SKILL.md" ] && [ -d "./references" ]; then
    pwd
    return 0
  fi

  [ -n "$DEFAULT_REPO_URL" ] || die "Cannot find local TDL-Skill files. Set TDL_SKILL_REPO_URL to the GitHub repo URL for remote installs."

  TDL_TMP_ROOT="$(mktemp -d)"
  archive="$TDL_TMP_ROOT/tdl-skill.tar.gz"
  repo_archive="${DEFAULT_REPO_URL%/}/archive/refs/heads/${DEFAULT_BRANCH}.tar.gz"

  info "Downloading TDL-Skill from $repo_archive"
  curl -fsSL "$repo_archive" -o "$archive"
  tar -xzf "$archive" -C "$TDL_TMP_ROOT"
  found="$(find "$TDL_TMP_ROOT" -maxdepth 2 -type f -name SKILL.md -print -quit)"
  [ -n "$found" ] || die "Downloaded archive did not contain SKILL.md"
  dirname "$found"
}

write_claude_file() {
  target="$1"
  domain="$2"
  file="$target/CLAUDE.md"

  if [ -f "$file" ] && grep -q "BEGIN TDL-SKILL" "$file"; then
    info "CLAUDE.md already contains TDL-Skill instructions"
    return 0
  fi

  if [ -f "$file" ]; then
    printf '\n' >> "$file"
  fi

  cat >> "$file" <<EOF
<!-- BEGIN TDL-SKILL -->
# TDL-Skill Learning Mentor

Use the project-local TDL framework in \`.tdl-skill/framework/SKILL.md\`.

Current learning domain: ${domain}

Rules:
- Start with assessment, then a micro challenge.
- Do not explain everything before the learner attempts.
- Prefer hints before explanations and explanations before full solutions.
- Persist learner state in \`.tdl-skill/state/\` after meaningful interactions.
- Update \`.tdl-skill/journey.md\` as the human-readable learning book after meaningful interactions.
- Use learner-provided resources as primary sources.
- Create deep-dive branches when the learner is blocked, then restore the checkpoint.

Suggested first learner prompt:
"Start Phase 0 assessment now. Ask me only the minimum questions needed to understand my current level, goals, available time, preferred learning style, and resources. After the assessment, give me one small micro-challenge before explaining anything."
<!-- END TDL-SKILL -->
EOF
}

write_codex_file() {
  target="$1"
  domain="$2"
  file="$target/AGENTS.md"

  if [ -f "$file" ] && grep -q "BEGIN TDL-SKILL" "$file"; then
    info "AGENTS.md already contains TDL-Skill instructions"
    return 0
  fi

  if [ -f "$file" ]; then
    printf '\n' >> "$file"
  fi

  cat >> "$file" <<EOF
<!-- BEGIN TDL-SKILL -->
# TDL-Skill Learning Mentor

When helping the learner in this project, load \`.tdl-skill/framework/SKILL.md\`.

Current learning domain: ${domain}

Persist learning state in \`.tdl-skill/state/\`, update \`.tdl-skill/journey.md\`, and follow the mastery-first learning loop.

Suggested first learner prompt:
"Start Phase 0 assessment now. Ask me only the minimum questions needed to understand my current level, goals, available time, preferred learning style, and resources. After the assessment, give me one small micro-challenge before explaining anything."
<!-- END TDL-SKILL -->
EOF
}

write_generic_prompt() {
  target="$1"
  domain="$2"
  file="$target/TDL_PROMPT.md"

  cat > "$file" <<EOF
# TDL-Skill Prompt

Use \`.tdl-skill/framework/SKILL.md\` as your main instruction file.

Learning domain: ${domain}

Start by assessing my current level, goals, time, preferences, confidence, and resources. Then give me one tiny challenge before explaining the concept. Persist learner state in \`.tdl-skill/state/\` and update \`.tdl-skill/journey.md\` after meaningful interactions.

## First Prompt

\`\`\`text
Use the TDL-Skill framework in this repo.

My learning domain is ${domain}.

Start Phase 0 assessment now. Ask me only the minimum questions needed to understand my current level, goals, available time, preferred learning style, and any resources I want to use.

After the assessment, give me one small micro-challenge before explaining anything.
\`\`\`

## After Assessment

\`\`\`text
Based on my answers, update .tdl-skill/state/learner-profile.json, .tdl-skill/state/learning-state.json, and .tdl-skill/journey.md, then give me the first micro-challenge.
\`\`\`
EOF
}

write_journey_file() {
  target="$1"
  domain="$2"
  force="$3"
  ts="$(now_utc)"
  file="$target/.tdl-skill/journey.md"

  if [ "$force" != "true" ] && [ -f "$file" ]; then
    info "Keeping existing journey book at $file"
    return 0
  fi

  mkdir -p "$target/.tdl-skill"
  cat > "$file" <<EOF
# Learning Journey

Domain: ${domain}
Learner: local-learner
Started: ${ts}

This document is the human-readable learning record. It should let the learner review what happened, and it should let a new agent continue the journey when JSON state is missing or stale.

## Current Position

- Current domain: ${domain}
- Current topic: Assessment
- Current stage: assessment
- Current challenge: Assess learner level, goals, time, preferences, confidence, and available resources.
- Next action: Run Phase 0 assessment, then give one micro-challenge.

## Learner Profile Summary

- Goals:
  - Build practical mastery in ${domain}.
- Available time:
- Preferred learning style:
- Preferred resources:
- Known strengths:
- Known struggle areas:

## Resource Index

No learner resources registered yet.

## Timeline

### ${ts} - Project Initialized

The TDL-Skill framework was initialized for ${domain}.

Initial state:

- Status: ACTIVE
- Stage: assessment
- Next action: ask minimum Phase 0 assessment questions.

## Concept Progress

No concepts assessed yet.

## Curiosity And Open Questions

No curiosity items captured yet.

## Mistakes And Misconceptions

No misconceptions captured yet.

## Deep Dives

No deep dives started yet.

## Revision Log

No revision tasks scheduled yet.

## Resume Brief

If continuing from this document only, start by asking the Phase 0 assessment questions for ${domain}. Then give one small micro-challenge before explaining anything.
EOF
}

write_state_files() {
  target="$1"
  domain="$2"
  force="$3"
  domain_json="$(printf '%s' "$domain" | json_escape)"
  slug="$(slugify "$domain")"
  [ -n "$slug" ] || slug="learning-domain"
  ts="$(now_utc)"

  mkdir -p "$target/.tdl-skill/state"

  if [ "$force" != "true" ] && [ -f "$target/.tdl-skill/state/learning-state.json" ]; then
    info "Keeping existing learner state in $target/.tdl-skill/state"
    return 0
  fi

  cat > "$target/.tdl-skill/state/learner-profile.json" <<EOF
{
  "learner_id": "local-learner",
  "created_at": "$ts",
  "updated_at": "$ts",
  "goals": [
    "Build practical mastery in ${domain}"
  ],
  "available_time": "",
  "preferences": {
    "explanation_style": "",
    "challenge_size": "small",
    "preferred_modalities": [],
    "preferred_resources": []
  },
  "strengths": [],
  "struggles": []
}
EOF

  cat > "$target/.tdl-skill/state/learning-state.json" <<EOF
{
  "learner_id": "local-learner",
  "status": "ACTIVE",
  "current_domain": $domain_json,
  "current_topic": "Assessment",
  "current_stage": "assessment",
  "current_challenge": {
    "id": "${slug}-assessment-001",
    "prompt": "Assess learner level, goals, time, preferences, confidence, and available resources for ${domain}.",
    "difficulty": 1,
    "resource_refs": []
  },
  "last_attempt": "",
  "last_feedback": "",
  "next_action": "Run Phase 0 assessment, then give one micro challenge.",
  "active_branch_id": null,
  "checkpoint": {
    "id": "${slug}-checkpoint-001",
    "created_at": "$ts",
    "topic": "Assessment",
    "stage": "assessment",
    "challenge_id": "${slug}-assessment-001",
    "last_attempt": "",
    "next_action": "Run Phase 0 assessment."
  },
  "updated_at": "$ts"
}
EOF

  cat > "$target/.tdl-skill/state/progress.json" <<EOF
{
  "learner_id": "local-learner",
  "concepts": []
}
EOF

  cat > "$target/.tdl-skill/state/curiosity.json" <<EOF
{
  "learner_id": "local-learner",
  "items": []
}
EOF

  cat > "$target/.tdl-skill/state/revision-plan.json" <<EOF
{
  "learner_id": "local-learner",
  "generated_at": "$ts",
  "tasks": []
}
EOF

  cat > "$target/.tdl-skill/state/resource-index.json" <<EOF
{
  "learner_id": "local-learner",
  "resources": []
}
EOF

  cat > "$target/.tdl-skill/state/learning-branches.json" <<EOF
{
  "learner_id": "local-learner",
  "branches": []
}
EOF

  cat > "$target/.tdl-skill/state/concept-graph.json" <<EOF
{
  "domain": $domain_json,
  "nodes": [],
  "edges": []
}
EOF
}

main() {
  target=""
  domain=""
  agent="claude"
  force="false"

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --domain)
        shift
        [ "$#" -gt 0 ] || die "--domain requires a value"
        domain="$1"
        ;;
      --agent)
        shift
        [ "$#" -gt 0 ] || die "--agent requires a value"
        agent="$1"
        ;;
      --force)
        force="true"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      -*)
        die "Unknown option: $1"
        ;;
      *)
        if [ -z "$target" ]; then
          target="$1"
        else
          die "Unexpected argument: $1"
        fi
        ;;
    esac
    shift
  done

  [ -n "$target" ] || {
    usage
    exit 1
  }

  mkdir -p "$target"
  target="$(cd "$target" && pwd -P)"

  if [ -z "$domain" ]; then
    printf 'What skill or domain do you want to learn? '
    IFS= read -r domain
  fi

  [ -n "$domain" ] || die "Learning domain cannot be empty"

  case "$agent" in
    claude|codex|generic|all) ;;
    *) die "--agent must be claude, codex, generic, or all" ;;
  esac

  source_dir="$(resolve_source_dir)"
  framework_dir="$target/.tdl-skill/framework"
  mkdir -p "$framework_dir"

  copy_dir "$source_dir/references" "$framework_dir/references" "$force"
  copy_dir "$source_dir/documentation" "$framework_dir/documentation" "$force"
  copy_dir "$source_dir/schemas" "$framework_dir/schemas" "$force"
  copy_dir "$source_dir/templates" "$framework_dir/templates" "$force"
  copy_dir "$source_dir/examples" "$framework_dir/examples" "$force"
  copy_dir "$source_dir/scripts" "$framework_dir/scripts" "$force"

  if [ "$force" = "true" ] || [ ! -f "$framework_dir/SKILL.md" ]; then
    cp "$source_dir/SKILL.md" "$framework_dir/SKILL.md"
  fi

  write_state_files "$target" "$domain" "$force"
  write_journey_file "$target" "$domain" "$force"

  case "$agent" in
    claude)
      write_claude_file "$target" "$domain"
      ;;
    codex)
      write_codex_file "$target" "$domain"
      ;;
    generic)
      write_generic_prompt "$target" "$domain"
      ;;
    all)
      write_claude_file "$target" "$domain"
      write_codex_file "$target" "$domain"
      write_generic_prompt "$target" "$domain"
      ;;
  esac

  info ""
  info "TDL-Skill initialized in $target"
  info "Domain: $domain"
  info "Framework: $target/.tdl-skill/framework"
  info "State: $target/.tdl-skill/state"
  info "Journey: $target/.tdl-skill/journey.md"
  info ""
  info "Next: open the project with your agent and ask it to follow the TDL-Skill instructions."
}

main "$@"
