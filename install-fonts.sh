#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

git submodule update --init --recursive

GOOGLE_FONTS_DIR="$(pwd)/google-fonts"
FONTS_DIR="$(pwd)/fonts"

DST_UPRIGHT_FONT_SUFFIX="Upright"
DST_BOLD_FONT_SUFFIX="Bold"

function install_font {
  SRC_FONT_DIR="${GOOGLE_FONTS_DIR}/$1"
  SRC_FONT_NAME="$2"
  SRC_UPRIGHT_FONT_SUFFIX="$3"
  SRC_BOLD_FONT_SUFFIX="$4"
  DST_FONT_DIR="$5"
  DST_FONT_NAME="$6"
  DST_UPRIGHT_FONT_SUFFIX="$7"
  DST_BOLD_FONT_SUFFIX="$8"

  DST_FONT_DIR="${DST_FONT_DIR}/${DST_FONT_NAME}"
  mkdir -p "$DST_FONT_DIR"
  cp "${SRC_FONT_DIR}/${SRC_FONT_NAME}-${SRC_UPRIGHT_FONT_SUFFIX}.ttf" "${DST_FONT_DIR}/${DST_FONT_NAME}-${DST_UPRIGHT_FONT_SUFFIX}.ttf"
  cp "${SRC_FONT_DIR}/${SRC_FONT_NAME}-${SRC_BOLD_FONT_SUFFIX}.ttf" "${DST_FONT_DIR}/${DST_FONT_NAME}-${DST_BOLD_FONT_SUFFIX}.ttf"
}

# Comma-separated font spec:
# font name to be used in the data file
# font directory relative the google-fonts submodule
# font name up to and excluding the font name and weight delimiter (e.g., PT_Sans-Web-Regular.ttf => PT_Sans-Web).
# source font suffix to be used as upright font
# source font suffix to be used as bold font
declare -a fonts_spec=(
  "Barlow,ofl/barlow,Barlow,Regular,SemiBold"
  "Cardo,ofl/cardo,Cardo,Regular,Bold"
  "CormorantGaramond,ofl/cormorantgaramond,CormorantGaramond,Medium,SemiBold"
  "CrimsonText,ofl/crimsontext,CrimsonText,Regular,SemiBold"
  "FiraSans,ofl/firasans,FiraSans,Light,Regular"
  "Glegoo,ofl/glegoo,Glegoo,Regular,Bold"
  "Hind,ofl/hind,Hind,Light,Regular"
  "HindMadurai,ofl/hindmadurai,HindMadurai,Light,Regular"
  "HindSiliguri,ofl/hindsiliguri,HindSiliguri,Light,Regular"
  "IBMPlexSerif,ofl/ibmplexserif,IBMPlexSerif,Light,Regular"
  "Kanit,ofl/kanit,Kanit,Light,Regular"
  "Lato,ofl/lato,Lato,Light,Regular"
  "LibreBaskerville,ofl/librebaskerville,LibreBaskerville,Regular,Bold"
  "Merriweather,ofl/merriweather,Merriweather,Light,Regular"
  "MontserratAlternates,ofl/montserratalternates,MontserratAlternates,Regular,Medium"
  "Mukta,ofl/mukta,Mukta,Light,Regular"
  "NanumGothic,ofl/nanumgothic,NanumGothic,Regular,Bold"
  "NoticiaText,ofl/noticiatext,NoticiaText,Regular,Bold"
  "Oxygen,ofl/oxygen,Oxygen,Regular,Bold"
  "Poppins,ofl/poppins,Poppins,Light,Regular"
  "PTSans,ofl/ptsans,PT_Sans-Web,Regular,Bold"
  "PTSerif,ofl/ptserif,PT_Serif-Web,Regular,Bold"
  "Sarabun,ofl/sarabun,Sarabun,Regular,Medium"
  "Spectral,ofl/spectral,Spectral,Light,Medium"
  "Tajawal,ofl/tajawal,Tajawal,Regular,Bold"
  "Tinos,apache/tinos,Tinos,Regular,Bold"
  "TitilliumWeb,ofl/titilliumweb,TitilliumWeb,Regular,SemiBold"
  "Ubuntu,ufl/ubuntu,Ubuntu,Light,Regular"
  "ZillaSlab,ofl/zillaslab,ZillaSlab,Regular,Medium"
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
    "${fs[4]}" \
    "$FONTS_DIR" \
    "${fs[0]}" \
    "$DST_UPRIGHT_FONT_SUFFIX" \
    "$DST_BOLD_FONT_SUFFIX"
done
echo "Finished installing fonts." >&2

echo >&2
echo "IMPORTANT: In your data file, fonts_spec should be set to '$FONTS_DIR'." >&2
