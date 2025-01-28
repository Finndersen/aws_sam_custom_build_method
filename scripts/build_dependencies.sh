#!/bin/bash

echo "Building dependencies"
deps_dir="$(dirname "$ARTIFACTS_DIR")/dependencies"

if [ -d "$deps_dir" ]; then
  echo "Dependencies already built"
  exit 0
fi

echo "$deps_dir"
mkdir -p "$deps_dir"
python -m pip install -r requirements.txt -t "$deps_dir"
# Remove library binaries to reduce package size
#rm -rf "$deps_dir/bin"