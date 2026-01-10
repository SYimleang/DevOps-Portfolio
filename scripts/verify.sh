#!/usr/bin/env bash
set -euo pipefail

echo "===> Verifying build output..."

test -f dist/index.html || (echo "Error: index.html not found!" && exit 1)

echo "Verification passed!"