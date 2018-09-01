#!/usr/bin/env bash
#
# review.sh
# 2018-08-28
# CC0 Public Domain

for x in {10..1}; do
    notes=$(date --date="$x days ago" -I).pdf
    mupdf $HOME/raw/$notes
done
