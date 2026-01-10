#!/usr/bin/env bash
set -euo pipefail

echoo "===> Aggregating uptime data..."

mkdir -p status
TS=$(date -u +"%Y-%m-%dT%H:00:00Z")

TOTAL=$(ls samples | wc -l)
UP=$(grep '"up":1' samples/*.json | wc -l)

AVAIL=$(awk "BEGIN { printf \"%.3f\", ($UP/$TOTAL)*100 }")

jq -s '[.[].latency_ms] | sort | .[length*0.95|floor]' samples/*.json > p95.txt
P95=$(cat p95.txt)

echo "{\"hour\":\"$TS\",\"availability\":$AVAIL,\"p95_latency_ms\":$P95}" >> status/hourly.ndjson

echo "Aggregation complete!"