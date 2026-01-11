#!/usr/bin/env bash
set -euo pipefail

echoo "===> Aggregating uptime data..."

mkdir -p status

TS=$(date -u +"%Y-%m-%dT%H:00:00Z")
FILE=status/hourly.ndjson

UP=0
LATENCIES=()

for i in {1..12}; do
START=$(date +%s%3N)
HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" --max-time 5 https://YOUR_SITE/health.html || echo 000)
END=$(date +%s%3N)

LAT=$((END - START))
LATENCIES+=($LAT)

[ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ] && UP=$((UP+1))

sleep 5
done

AVAIL=$(awk "BEGIN { printf \"%.3f\", ($UP/12)*100 }")

P95=$(printf "%s\n" "${LATENCIES[@]}" | sort -n | awk 'NR==int(NR*0.95)')

echo "{\"hour\":\"$TS\",\"availability\":$AVAIL,\"p95_latency_ms\":$P95}" >> "$FILE"

echo "Aggregation complete!"