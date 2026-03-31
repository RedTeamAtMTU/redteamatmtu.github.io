#!/usr/bin/env sh
# Ensure all minutes in content/minutes/YYYY-MM-DD.md occur on a Thursday


for i in content/minutes/*-*-*.md; do
    filename="$(basename "${i}")"

    date="$(echo "${filename}" | cut -d'.' -f1)"

    day_of_week="$(date -d "${date}" +"%A")"

    if [ "${day_of_week}" != "Thursday" ]; then
      echo "${date} is a ${day_of_week}!"
    fi
done
