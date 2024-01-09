#!/bin/bash
PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin

BRANCH=$1

echo "Hook received. Pulling updates for branch ${BRANCH}..."
cd /code
[ "$(git rev-parse --abbrev-ref HEAD)" == "$BRANCH" ] || git checkout $BRANCH
git fetch origin
git pull --rebase origin $BRANCH
mkdocs build --site-dir /usr/share/nginx/html
