#!/usr/bin/env bash


# Explicit environment for cron
export HOME="/home/AnHuynh"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"


#export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/ssh-agent.socket}"

[ -z "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


# Auto-start ssh-agent and load key if not already loaded (cron-safe)
if ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)" >/dev/null
    ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null || ssh-add "$HOME/.ssh/id_rsa" 2>/dev/null
fi


REPO_PATH="$HOME/e5"
LOG_FILE="$REPO_PATH/noreply.txt"

HOLIDAYS=(
  "01-01"
  "04-30"
  "05-01"
  "09-02"
)

TET_START="2026-02-12"
TET_END="2026-02-25"

WEATHER=$(curl -s "wttr.in/Ho+Chi+Minh?format=%t+%C" | sed 's/+//;s/%//')
TODAY=$(date +%Y-%m-%d)
TODAY_MD=$(date +%m-%d)
WEEKDAY=$(date +%u)
NOW_HM=$(date +%H:%M)
HOUR=$(date +%H)
RANDOM_SKIP=$(( RANDOM % 10 ))

within_tet() {
  [[ "$TODAY" > "$TET_START" && "$TODAY" < "$TET_END" ]]
}

is_holiday() {
  for h in "${HOLIDAYS[@]}"; do
    [[ "$h" == "$TODAY_MD" ]] && return 0
  done
  return 1
}

if [[ $WEEKDAY -gt 5 ]]; then
  if [[ $WEEKDAY -eq 6 ]]; then
    true
  fi
fi

if within_tet; then
  exit 0
fi

if is_holiday; then
  exit 0
fi

if [[ $WEEKDAY -le 5 ]]; then
  if [[ $RANDOM_SKIP -eq 0 ]]; then
    exit 0
  fi

  if [[ $WEEKDAY -eq 1 && $HOUR -lt 11 ]]; then
    exit 0
  fi

  if [[ $WEEKDAY -eq 5 && $HOUR -gt 13 ]]; then
    exit 0
  fi

  if (( RANDOM % 2 )); then
    exit 0
  fi
fi

echo "### $TODAY $NOW_HM" >> "$LOG_FILE"
echo "Weather: $WEATHER" >> "$LOG_FILE"
echo "Uptime: $(uptime -p)" >> "$LOG_FILE"
#echo "Mood: $(shuf -n 1 <<< $'Functional\nSurviving\nRunning on caffeine\nConsidering quitting\nJust vibes')" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "$(date) - Ran commit logic" >> /home/AnHuynh/cron-debug.log

cd "$REPO_PATH"
git add .
git commit -m "update $TODAY $NOW_HM"
git push origin main

