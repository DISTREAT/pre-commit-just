#!/bin/sh
set -eu

if ! command -v just /dev/null 2>&1; then
    echo "no just binary found; not running" >&2
    exit 0
fi

status=0

for file in "$@"; do
    if ! just --fmt --unstable --check -f "$file" >/dev/null 2>&1; then
        echo "fixing $file" >&2
        just --fmt --unstable -f "$file" >/dev/null 2>&1
        status=1
    fi
done

exit "$status"
