#!/bin/bash

set -xe

PANDOC_URL="https://github.com/jgm/pandoc/releases/download/2.17.0.1/pandoc-2.17.0.1-1-amd64.deb"
PANDOC_DL_LOCATION="/tmp/pandoc.deb"

apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -qq \
  texlive-full \
  unzip \
  wget
apt-get clean
rm -rf /var/lib/apt/lists/*

# Manually install pandoc, repo version is very old.
wget "$PANDOC_URL" --no-verbose --output-document "$PANDOC_DL_LOCATION"
dpkg --install "$PANDOC_DL_LOCATION"
rm "$PANDOC_DL_LOCATION"
