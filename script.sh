#!/usr/bin/env bash

##
## This script will adapt and install Yaru icons pack for best GNOME "Vanilla" experience
##
## Usage:
##  script.sh yaru_folder (copy icons to $HOME/.local/share/icons)
##  script.sh yaru_folder --test (copy icons to ./icons)
##
## The icons in this folder were taken directly from Ubuntu
## Sources for Yaru icons: https://github.com/ubuntu/yaru
##

ICON_BASE_DIR="./$1"

if [[ "$2" == "--test" ]]; then
    DEST_BASE_DIR="./icons" #TEST
else
    DEST_BASE_DIR="$HOME/.local/share/icons" #PROD
fi

# Checks before run script
if [[ -z "$1" ]]; then
    echo -e "\033[31mERROR\033[0m argument is missing!"
    echo "Usage: $(basename $0) yaru_folder"
    exit 1
elif [[ -d "./$1" ]]; then
    echo
    echo "Starting install \"$1\" icons pack..."
    echo
else
	echo -e "\033[31mERROR\033[0m folder \"$1\" not found!"
    exit 1
fi

# If "Yaru" icons pack already exist
if [[ -d "$DEST_BASE_DIR/Yaru" ]]; then
    echo -e "\033[31mERROR\033[0m \"$DEST_BASE_DIR/Yaru\" folder already exist!"
    exit 1
fi

# If not exist, create icons folder
if ! [[ -d $DEST_BASE_DIR ]]; then
    echo "Create \"$DEST_BASE_DIR\" folder"
    mkdir $DEST_BASE_DIR
fi

# Copy icons pack to icons folder
echo "Copy Yaru icons pack to \"$DEST_BASE_DIR\""
cp -R $ICON_BASE_DIR/* $DEST_BASE_DIR
echo

# Process each Yaru icons folder
for YARU_DIR in "$DEST_BASE_DIR"/Yaru*; do
    [ -d "$YARU_DIR" ] || continue

    echo "$YARU_DIR : "

    echo " - Remove scalable* subfolders"
    rm -R $YARU_DIR/scalable*

    echo " - Remove icon-theme.cache file"
    rm $YARU_DIR/icon-theme.cache

    echo " - Replace Humanity with Adwaita inherits in index.theme"
    sed -i "s/Humanity/Adwaita/g" "$YARU_DIR/index.theme"

    echo " - Clean all scalable references in index.theme"
    # 1. Remove scalable*/* in "Directories"
    sed -i 's/,scalable.*\/.*//g' "$YARU_DIR/index.theme"
    # 2. Remove "[scalable*/*]" blocks
    sed -i '/\[scalable.*\/.*\]/,/^$/d' "$YARU_DIR/index.theme"
    # 3. Remove extra eventual commas
    sed -i 's/,,/,/g; s/,$//' "$YARU_DIR/index.theme"

    echo
done

echo "Done!"
