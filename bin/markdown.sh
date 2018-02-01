#!/usr/bin/env bash

# Script location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Convert all markdown src files to tex files using pandoc
for f in $(find $DIR/../src -name '*.md'); do
  # --biblatex for [@biblesrc] citations
  # "${f%.*}" is presumably filename withou suffix :O
  # I don't understand the thing either see SO if you care
  pandoc $f --biblatex -t latex > "${f%.*}".tex
done
