#!/bin/bash

set -e

FONTS_URL="https://fonts.google.com/download?family=Open%20Sans|Lato|Raleway|Ubuntu|Catamaran|Montserrat|Poppins|Source%20Sans%20Pro|Noto%20Sans|Nunito|Fira%20Sans|Quicksand|Dosis|Oxygen"
FONTS_DIR="${1:-/fonts}"
FONTS_DL_DIR="/tmp/fonts"
FONTS_DL_FILE="${FONTS_DL_DIR}/fonts.zip"
DST_UPRIGHT_FONT_SUFFIX="Upright"
DST_BOLD_FONT_SUFFIX="Bold"

mkdir -p "$FONTS_DL_DIR"
echo "Downloading fonts..." >&2
wget "$FONTS_URL" --quiet --output-document="$FONTS_DL_FILE"
unzip -qq "$FONTS_DL_FILE" -d "$FONTS_DL_DIR"
rm "$FONTS_DL_FILE"

function install_font {
  SRC_FONT_DIR="$1"
  SRC_UPRIGHT_FONT_SUFFIX="$2"
  SRC_BOLD_FONT_SUFFIX="$3"
  DST_FONT_DIR="$4"
  DST_UPRIGHT_FONT_SUFFIX="$5"
  DST_BOLD_FONT_SUFFIX="$6"
  FONT_NAME="$7"

  DST_FONT_DIR="${DST_FONT_DIR}/${FONT_NAME}"
  mkdir -p "$DST_FONT_DIR"
  mv "${SRC_FONT_DIR}/${FONT_NAME}-${SRC_UPRIGHT_FONT_SUFFIX}.ttf" "${DST_FONT_DIR}/${FONT_NAME}-${DST_UPRIGHT_FONT_SUFFIX}.ttf"
  mv "${SRC_FONT_DIR}/${FONT_NAME}-${SRC_BOLD_FONT_SUFFIX}.ttf" "${DST_FONT_DIR}/${FONT_NAME}-${DST_BOLD_FONT_SUFFIX}.ttf"
}

# Comma-separated font spec:
# font name
# source font path
# source font suffix to be used as upright font
# source font suffix to be used as bold font
declare -a fonts_spec=(
  "Catamaran,${FONTS_DL_DIR}/Catamaran/static,Regular,Medium"
  "Dosis,${FONTS_DL_DIR}/Dosis/static,Regular,Medium"
  "FiraSans,${FONTS_DL_DIR}/Fira_Sans,Light,Regular"
  "Lato,${FONTS_DL_DIR}/Lato,Regular,Bold"
  "Montserrat,${FONTS_DL_DIR}/Montserrat/static,Regular,Medium"
  "NotoSans,${FONTS_DL_DIR}/Noto_Sans,Regular,Bold"
  "Nunito,${FONTS_DL_DIR}/Nunito/static,Regular,SemiBold"
  "OpenSans,${FONTS_DL_DIR}/Open_Sans/static/OpenSans,Regular,SemiBold"
  "Oxygen,${FONTS_DL_DIR}/Oxygen,Regular,Bold"
  "Poppins,${FONTS_DL_DIR}/Poppins,Light,Regular"
  "Quicksand,${FONTS_DL_DIR}/Quicksand/static,Regular,SemiBold"
  "Raleway,${FONTS_DL_DIR}/Raleway/static,Regular,SemiBold"
  "SourceSansPro,${FONTS_DL_DIR}/Source_Sans_Pro,Regular,SemiBold"
  "Ubuntu,${FONTS_DL_DIR}/Ubuntu,Light,Regular"
)

# Install fonts with predictable filenames / paths to make it easier to load
# them using \setmainfont.
echo "Installing fonts..." >&2
for font_spec in "${fonts_spec[@]}"; do
  IFS="," read -r -a fs <<< "$font_spec"
  echo "Installing font: ${fs[0]}..." >&2
  install_font \
    "${fs[1]}" \
    "${fs[2]}" \
    "${fs[3]}" \
    "$FONTS_DIR" \
    "$DST_UPRIGHT_FONT_SUFFIX" \
    "$DST_BOLD_FONT_SUFFIX" \
    "${fs[0]}"
done
echo "Finished installing fonts." >&2

rm -r "$FONTS_DL_DIR"
