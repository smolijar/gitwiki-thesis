#!/usr/bin/env bash

# Script location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Convert all markdown src files to tex files using pandoc
for f in $(find $DIR/../src -name '*.md'); do
  # --biblatex for [@biblesrc] citations
  # "${f%.*}" is presumably filename withou suffix :O
  # I don't understand the thing either see SO if you care
  pandoc $f --biblatex --listings --filter pandoc-fignos -t latex |
    # replace lstlisting with listing and minted
    # begin
    sed -r "s@^\\\begin\{lstlisting\}\[language=(\w+), caption=([^,]+), label=(\S+)\]@\\\begin{listing}\n\\\caption{\2}\\\label{\3}\n\\\begin{minted}{\1}@g" |
    # end
    sed "s@\\\end{lstlisting}@\\\end{minted}\n\\\end{listing}@g" |
    
    $DIR/abbr.rb |
    # mint inline isntead of lstinline
    sed "s@\\\lstinline@\\\mintinline{latex}@g"> "${f%.*}".tex

done
