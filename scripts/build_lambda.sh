#!/bin/bash

lambda_src_path="$1"
lambda_name=$(basename "$ARTIFACTS_DIR")
echo "Building Lambda $lambda_name"

deps_dir="$(dirname "$ARTIFACTS_DIR")/dependencies"

cp -r "$deps_dir"/* "$ARTIFACTS_DIR"
cp -r src/shared "$ARTIFACTS_DIR"
cp -r "$lambda_src_path" "$ARTIFACTS_DIR"