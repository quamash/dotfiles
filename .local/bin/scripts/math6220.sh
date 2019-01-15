#! /bin/sh
#
# math6220.sh
# 2019-01-14
# CC0 Public Domain

pandoc -s --filter pandoc-citeproc -o ${1%.*}.tex $1 -f markdown-auto_identifiers 
latexmk -pdf ${1%.*}.tex
latexmk -c ${1%.*}.tex
mupdf ${1%.*}.pdf &
