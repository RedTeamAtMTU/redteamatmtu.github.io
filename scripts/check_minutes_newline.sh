#!/usr/bin/env sh
# quick-and-dirty ripgrep command to check if minutes have text not seperated by two newlines
# this will squash into one line, which probably isn't what was intended


rg -NIU '^[A-Za-z0-9].*\n^[A-Za-z0-9]' content/minutes/*.md | rg -ve '^title:' -e '^date:' -e '^toc:' -e '^draft:' -e '^summary:' -e '^weight:' -e '^type:'
