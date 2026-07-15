#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

generator="${S3G_MAX_GENERATOR:-Unix Makefiles}"
make_program="${S3G_MAX_MAKE_PROGRAM:-/opt/homebrew/bin/gmake}"
build_dir="$repo_dir/build"

if [ "$generator" = "Unix Makefiles" ]; then
  build_dir="$repo_dir/build-make"
  cmake -S "$repo_dir" -B "$build_dir" -G "$generator" -DCMAKE_MAKE_PROGRAM="$make_program" -DCMAKE_BUILD_TYPE=Release
elif [ "$generator" = "Xcode" ]; then
  build_dir="$repo_dir/build-xcode"
  cmake -S "$repo_dir" -B "$build_dir" -G "$generator"
else
  cmake -S "$repo_dir" -B "$build_dir" -G "$generator"
fi

cmake --build "$build_dir" --config Release

mkdir -p "$repo_dir/package/externals"
