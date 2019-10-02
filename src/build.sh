#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Wrong number of arguments!"
    echo "Example usage: ./build.sh main.tex"
    exit 1
fi

BASE="${1%.*}"
PDFLATEX_OPTIONS="-interaction=nonstopmode"

pdflatex $PDFLATEX_OPTIONS $BASE.tex
if [ $? -ne 0 ]; then
    echo "Compilation error. Please check log output."
    exit 1
fi
bibtex $BASE
makeindex $BASE
pdflatex $PDFLATEX_OPTIONS $BASE.tex
pdflatex $PDFLATEX_OPTIONS $BASE.tex

# cleanup
find . -type f | grep -E "*.aux|*.blg|*.dvi|*.log|*.lot|*.lof|*.toc|*.gz|*.bbl|*.fls|*.idx|*.ind|*.ilg|*.out" | xargs rm

exit 0
