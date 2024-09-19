#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

check_program() {
    if ! command -v "$1" > /dev/null 2>&1; then
        echo "Error: $1 not installed, exiting."
        exit 1
    fi
}


log() {
      STEP=$1
      MESSAGE=$2
      echo "${YELLOW}[${STEP}]: ${GREEN}${MESSAGE}${NC}"
}


check_program pdflatex
check_program bibtex

echo "------------- Building PDF -------------"

log "pdflatex ms.tex" "Compiling LaTeX..."
pdflatex ms.tex > /dev/null 2>&1

log "bibtex ms" "Synchronizing bibtex..."
bibtex ms > /dev/null 2>&1

log "pdflatex ms.tex" "Synchronizing citations..."
pdflatex ms.tex > /dev/null 2>&1

log "pdflatex ms.tex" "Synchronizing ToC..."
pdflatex ms.tex > /dev/null 2>&1

rm *.aux *.bbl *.blg *.log *.out *.toc

echo "-----------------------------------------"

echo "${YELLOW} PDF File Generated -> ${GREEN}./ms.pdf${NC}"
