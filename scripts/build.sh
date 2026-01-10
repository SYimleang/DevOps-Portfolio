#!/usr/bin/env bash
set -euo pipefail

echo "===> Building site..."

rm -rf dist
mkdir -p dist

cp -r src/* dist/

echo "Build complete!"