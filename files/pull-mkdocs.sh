#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin

echo "Changes detected. Pulling updates..."
cd /code
git pull --quiet --rebase origin main  # there seems to be a problem with TTY when using git pull
mkdocs build --site-dir /usr/share/nginx/html
