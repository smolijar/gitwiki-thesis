#!/usr/bin/env bash

# Script location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create PNGs from plantuml
for f in $(find $DIR/../src/assets/diagram -name '*.plantuml'); do
  plantuml $f
done
