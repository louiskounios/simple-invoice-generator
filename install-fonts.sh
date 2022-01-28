#!/bin/bash

set -xe

FONTS_DIR="/usr/local/share/fonts"
FONTS_URL="https://fonts.google.com/download?family=Open%20Sans|Lato|Raleway|Ubuntu|Catamaran"
FONTS_DL_LOCATION="/tmp/fonts.zip"

wget "$FONTS_URL" --no-verbose --output-document="$FONTS_DL_LOCATION"
unzip "$FONTS_DL_LOCATION" -d "$FONTS_DIR"
rm "$FONTS_DL_LOCATION"
