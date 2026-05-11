#!/bin/bash

set -e

echo -e "\nConfiguring Git tooling"
echo "=============================="

if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Skipping Git tooling configuration."
    exit 0
fi

if ! command -v delta >/dev/null 2>&1; then
    echo "delta is not installed. Skipping delta configuration."
    exit 0
fi

git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.line-numbers true
git config --global delta.side-by-side true
git config --global delta.syntax-theme Dracula
git config --global delta.navigate true
git config --global merge.conflictstyle diff3

echo "Git delta configured."
