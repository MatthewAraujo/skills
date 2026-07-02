#!/usr/bin/env bash
set -euo pipefail

# Configure this to the command you use to run your coding agent non-interactively.
# Example:
#   AGENT_CMD="codex exec"
#   AGENT_CMD="claude -p"
AGENT_CMD="${AGENT_CMD:-codex exec}"

MAX_TASKS="${MAX_TASKS:-50}"
RUN_DIR=".agent/task-loop"
mkdir -p "$RUN_DIR"

if [ ! -f "docs/TASKS.md" ]; then
  echo "docs/TASKS.md not found. Run task-planner first."
  exit 1
fi

for i in $(seq 1 "$MAX_TASKS"); do
  echo ""
  echo "==> Task loop iteration $i/$MAX_TASKS"

  if ! grep -Eq "Status:[[:space:]]*(ready|planned)" docs/TASKS.md; then
    echo "No ready/planned tasks found. Finished."
    exit 0
  fi

  BEFORE_HASH="$(git rev-parse HEAD)"
  TASKS_BEFORE="$(sha256sum docs/TASKS.md | awk '{print $1}')"

  PROMPT_FILE="$RUN_DIR/prompt-$i.md"

  cat >"$PROMPT_FILE" <<'PROMPT'
You are continuing this project from repository files only.

Do not rely on previous chat history.

Use the `task-runner` skill.

Goal:
Execute exactly one next runnable task from `docs/TASKS.md`.

Required behavior:
1. Load only the minimal necessary context:
   - `PROJECT.md`, if present
   - `CONTEXT.md`, if present
   - `docs/PRD.md`
   - `docs/TASKS.md`
   - relevant ADRs/glossary entries only if needed
   - relevant previous `docs/task-runs/*-summary.md` only if the selected task depends on them
2. Select exactly one task with `Status: ready` or `Status: planned`.
3. Create/update `docs/task-runs/<task-id>-context.md`.
4. Use `tdd` for that single task only.
5. Add or update tests when feasible.
6. Run relevant validation commands when possible.
7. Update `docs/TASKS.md` with the task status.
8. Create/update `docs/task-runs/<task-id>-summary.md`.
9. If the task is completed, write a meaningful commit subject to:

   `.agent/task-loop/last-commit-message.txt`

Commit message rules:
- Describe the actual code/documentation change.
- Do not use generic messages like "done task 2", "update files", or "fix stuff".
- Keep it short and specific.
- Example: "Add health check endpoint"
- Example: "Configure integration test database setup"

Stop after one task.
Do not start the next task.
PROMPT

  set +e
  $AGENT_CMD <"$PROMPT_FILE"
  AGENT_EXIT=$?
  set -e

  if [ "$AGENT_EXIT" -ne 0 ]; then
    echo "Agent failed with exit code $AGENT_EXIT. Stopping loop."
    exit "$AGENT_EXIT"
  fi

  if git diff --quiet; then
    TASKS_AFTER="$(sha256sum docs/TASKS.md | awk '{print $1}')"

    if [ "$TASKS_BEFORE" = "$TASKS_AFTER" ]; then
      echo "No repository changes and docs/TASKS.md did not change. Stopping to avoid an infinite loop."
      exit 1
    fi

    echo "No changes to commit."
    continue
  fi

  COMMIT_MSG_FILE="$RUN_DIR/last-commit-message.txt"

  if [ ! -s "$COMMIT_MSG_FILE" ]; then
    echo "Commit message file was not created."
    echo "Review changes manually:"
    git status --short
    exit 1
  fi

  COMMIT_MSG="$(head -n 1 "$COMMIT_MSG_FILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

  if [ -z "$COMMIT_MSG" ]; then
    echo "Commit message is empty. Stopping."
    exit 1
  fi

  echo "Committing: $COMMIT_MSG"
  git add -A
  git commit -m "$COMMIT_MSG"

  AFTER_HASH="$(git rev-parse HEAD)"

  if [ "$BEFORE_HASH" = "$AFTER_HASH" ]; then
    echo "Commit did not advance HEAD. Stopping."
    exit 1
  fi
done

echo "Reached MAX_TASKS=$MAX_TASKS. Stopping."
exit 0
