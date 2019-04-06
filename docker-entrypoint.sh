#!/bin/bash

set -xe

TEMPLATE_FILE="/simple-invoice/template.tex"
DATA_DIR="/datadir"
DATA_FILE="$DATA_DIR/data.yml"
OUTPUT_FILE="$DATA_DIR/invoice.pdf"

if [ ! -f "$DATA_FILE" ]; then
  echo "No data file provided. Using example data file instead."
  DATA_FILE="/simple-invoice/data.yml.example"
fi

exec pandoc "$DATA_FILE" --template="$TEMPLATE_FILE" --output "$OUTPUT_FILE" --verbose --pdf-engine=xelatex
