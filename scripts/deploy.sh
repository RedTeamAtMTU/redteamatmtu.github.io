#!/usr/bin/env sh
# Build & deploy site to RedTeam Webserver VM
# NOTE: No longer used after migrating to GitHub Pages

set -eu

# get this script's location
#   https://stackoverflow.com/a/29835459
# shellcheck disable=SC1007
script_path=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
project_path="$(dirname "${script_path}")"
html_path="${project_path}/public/"

#echo "===== Deleting Previous Build ====="
#rm -rf "${html_path}" # old, not needed due to "--cleanDestinationDir"

echo "===== Building Site ====="
hugo --gc --minify --cleanDestinationDir --source "${project_path}"

echo "===== Setting Permissions ====="
chmod -R u=rwX,go=rX "${html_path}"

echo "===== Deploying ====="
rsync -rltpz --delete --info=progress2 "${html_path}" redteam:~/public_html/

echo "===== Done! ====="

exit 0
