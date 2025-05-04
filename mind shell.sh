#!/bin/sh
echo -ne '\033c\033]0;mind shell\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/mind shell.x86_64" "$@"
