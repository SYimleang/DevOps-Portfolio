#!/usr/bin/env bash
set -e

STATUS_DIR="status"
LOG_FILE="$STATUS_DIR/log.ndjson"
SLO_FILE="$STATUS_DIR/slo.json"

WINDOW_DAYS=30
INTERVAL_MIN=5
TOTAL=$((WINDOW_DAYS * 24 * (60 / INTERVAL_MIN))) # every 5 minutes

mkdir -p "$STATUS_DIR"

if [ ! -f "$LOG_FILE" ]; then
  cat > "$SLO_FILE" <<EOF
{
  "schemaVersion": 1,
  "label": "availability",
  "message": "no data",
  "color": "lightgrey"
}
EOF
  exit 0
fi

UP_COUNT=$(tail -n $TOTAL status/log.ndjson | grep '"up":1' | wc -l)

AVAILABILITY=$(awk "BEGIN { printf \"%.3f\", ($UP_COUNT/$TOTAL)*100 }")

COLOR="green"
if (( $(echo "$AVAILABILITY < 99.9" | bc -l) )); then
  COLOR="yellow"
fi

cat > "$SLO_FILE" <<EOF
{
  "schemaVersion": 1,
  "label": "availability",
  "message": "${AVAILABILITY}%",
  "color": "$COLOR"
}
EOF
