#!/usr/bin/env bash

FONTS_DIR="./fonts"

./install-fonts.sh "$FONTS_DIR"

declare -a fonts=(
  "Catamaran"
  "Dosis"
  "FiraSans"
  "Lato"
  "Montserrat"
  "NotoSans"
  "Nunito"
  "OpenSans"
  "Oxygen"
  "Poppins"
  "Quicksand"
  "Raleway"
  "SourceSansPro"
  "Ubuntu"
)

echo "Generating example invoices..." >&2
for font in "${fonts[@]}"; do
  echo "Generating example invoice for ${font} font..." >&2
  data_file="/tmp/data.example.${font}.yml"
  ./generate-example-data-file.sh "$data_file" "$FONTS_DIR" "$font"
  pandoc "$data_file" --template="./template.tex" --output="./examples/${font}.pdf" --pdf-engine="xelatex" --quiet
  convert -quiet -density 300 "./examples/${font}.pdf" -quality 100 -resize 100% -alpha remove "./examples/${font}.png"
  rm "$data_file"
done
echo "Finished generating example invoices." >&2

rm -rf "$FONTS_DIR"
