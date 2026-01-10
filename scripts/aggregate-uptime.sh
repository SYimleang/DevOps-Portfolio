#!/usr/bin/env bash
set -euo pipefail

echoo "===> Aggregating uptime data..."

mkdir -p status

TS=$(date -u +"%Y-%m-%dT%H:00:00Z")

# last 12 samples = 1 hour
HOUR=$(tail -n 12 status/raw.ndjson)

TOTAL=$(echo "$HOUR" | wc -l)
UP=$(echo "$HOUR" | grep '"up":1' | wc -l)

AVAIL=$(awk "BEGIN { printf \"%.3f\", ($UP/$TOTAL)*100 }")

P95=$(echo "$HOUR" | jq '.latency_ms' | sort -n | awk 'NR==int(NR*0.95)')

echo "{\"hour\":\"$TS\",\"availability\":$AVAIL,\"p95_latency_ms\":$P95}" >> status/hourly.ndjson

# Remove processed samples
tail -n +13 status/raw.ndjson > status/raw.tmp || true
mv status/raw.tmp status/raw.ndjson

echo "Aggregation complete!"