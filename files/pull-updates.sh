#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin

echo "Hook received. Pulling updates..."
cd /code
git pull --quiet --rebase origin main  # I noticed an issue with TTY when using git pull, hence the --quiet
mkdocs build --site-dir /usr/share/nginx/html
