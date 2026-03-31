#!/usr/bin/env sh

set -eu

# get this script's location
#   https://stackoverflow.com/a/29835459
# shellcheck disable=SC1007
script_path=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
project_path="$(dirname "${script_path}")"

# Get today's date in YYYY-MM-DD
todays_date="$(date +%Y-%m-%d)"

printf "Meeting date as YYYY-MM-DD (Enter for %s): " "${todays_date}"
read -r date

# Using today's date if not given by user
if [ -z "$date" ]; then
  date="${todays_date}"
fi

# Ensure date is YYYY-MM-DD
if ! echo "$date" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
    echo "Error: Invalid date format. Must be YYYY-MM-DD" >&2
    exit 1
fi

new_minutes_path="${project_path}/content/minutes/${date}.md"
new_minutes_path_in_project="content/minutes/${date}.md"

# Check if minutes already exist
if [ -f "$new_minutes_path" ]; then
    echo "Error: Minutes already exist for ${date}!" >&2
    exit 1
fi

printf "Meeting title (Enter to leave blank): "
read -r title

# Minutes template
cat << ENDOFTEMPLATE > "${new_minutes_path}"
---
title: "${title}"
date: "${date}"
toc: true     # Show table of contents? true/false
draft: true   # set to false to show these minutes on the meeting minutes list.

summary: ""   # summary for link previews
weight: 1     # can be used to force positioning relative to other minutes.
type: docs    # Do not modify.

# Buttons for presentations / talk recordings:
# Text: text for the button
# icon: optional icon to sit on the left of the text
#   The RedTeam site uses fontawesome 5 free, you can search for all icons on:
#     https://fontawesome.com/v5/search
#   Some common icons you may want to use:
#     Google Slides Link: "fab fa-google-drive"
#     PDF File:           "fas fa-file-pdf"
#     Video File:         "fas fa-file-video"
#     PPTX File:          "fas fa-file-powerpoint"
# link: link for the button
buttons:
  - text: ""
    icon: ""
    link: ""
# Example for a Google Slides link:
#  - text: "Slides"
#    icon: "fab fa-google-drive"
#    link: "https://docs.google.com/presentation/d/1C9udMP01k8Wrxyt2N4RSkr501zM7Z5od/edit"

---

## Articles

## Talk

## Workshop

## Post-meeting
ENDOFTEMPLATE

# Get editor from user's enviornment, falling back to nvim/vi
editor=""
if [ -n "${VISUAL:-}" ]; then
    editor="$VISUAL"
elif [ -n "${EDITOR:-}" ]; then
    editor="$EDITOR"
elif command -v nvim >/dev/null 2>&1; then
    editor="nvim"
elif command -v vi >/dev/null 2>&1; then
    editor="vi"
else
    echo "No suitable editor found, file is at ${new_minutes_path}" >&2
    exit 1
fi

echo "Opening file in editor...."
"${editor}" "${new_minutes_path}"

printf "Are these minutes ready to be published? (\"draft: false\") (Y/n): "
read -r publish

# If user typed anything, don't publish.
if [ -n "$publish" ]; then
    echo "Not publishing \"${new_minutes_path_in_project}\"."
    echo "Set \"draft: false\" in ${new_minutes_path_in_project} when ready to publish."
    exit 0
fi

echo "Publishing \"${new_minutes_path_in_project}\"...."
sed -i 's/^draft: true/draft: false/g' "${new_minutes_path}"

printf "Redeploy site? (Y/n): "
read -r redeploy

# If user didn't type anything, redeploy site.
if [ -z "$redeploy" ]; then
  echo "Redeploying site..."
  exec "${script_path}/deploy.sh"
else
  echo "Not redeploying site."
fi

exit 0
