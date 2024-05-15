#!/usr/bin/env bash

cd "$(dirname "$0")"

FONTS_DIR="$(pwd)/fonts"

declare -a fonts=(
  "Barlow"
  "Cardo"
  "CormorantGaramond"
  "CrimsonText"
  "FiraSans"
  "Glegoo"
  "Hind"
  "HindMadurai"
  "HindSiliguri"
  "IBMPlexSerif"
  "Kanit"
  "Lato"
  "LibreBaskerville"
  "Merriweather"
  "MontserratAlternates"
  "Mukta"
  "NanumGothic"
  "NoticiaText"
  "Oxygen"
  "Poppins"
  "PTSans"
  "PTSerif"
  "Sarabun"
  "Spectral"
  "Tajawal"
  "Tinos"
  "TitilliumWeb"
  "Ubuntu"
  "ZillaSlab"
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
