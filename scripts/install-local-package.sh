#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
max_major="${S3G_MAX_VERSION:-9}"
package_root="${S3G_MAX_PACKAGE_ROOT:-$HOME/Documents/Max ${max_major}/Packages/s3g-max}"
package_source="$repo_dir/package"

if [ ! -d "$package_source/externals" ] || ! find "$package_source/externals" -name "*.mxo" -type d | grep -q .; then
  "$repo_dir/scripts/build-release.sh"
fi

mkdir -p "$(dirname "$package_root")"
if [ -L "$package_root" ]; then
  current_target="$(readlink "$package_root")"
  if [ "$current_target" = "$package_source" ]; then
    echo "s3g-max package symlink already installed at: $package_root"
    exit 0
  fi
fi

rm -rf "$package_root"
ln -s "$package_source" "$package_root"

echo "Linked s3g-max package:"
echo "  $package_root -> $package_source"
