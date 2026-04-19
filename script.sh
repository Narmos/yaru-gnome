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

if [[ "$2" == "--test" ]]; then # test "icons" folder destination
    DEST_BASE_DIR="./icons"
else # current user "icons" folder destination
    DEST_BASE_DIR="$HOME/.local/share/icons"
fi

# Checks before run script
if [[ $(id -u) -eq "0" ]]; then # sudo/root
	echo -e "\033[31mERROR\033[0m The script must not be run as root!"
	exit 1
fi

if [[ -z "$1" ]]; then # missing first parameter
    echo -e "\033[31mERROR\033[0m The first (required) parameter is missing!"
    echo " Usage: $(basename $0) yaru_folder"
    exit 1
elif [[ -d "./$1" ]]; then # first parameter is an existing folder
    echo
    echo "Starting install \"$1\" Yaru icon pack..."
    echo
else # first parameter is not an existing folder
	echo -e "\033[31mERROR\033[0m The \"$1\" folder was not found!"
    exit 1
fi

# If Yaru icon pack already exist
if [[ -d "$DEST_BASE_DIR/Yaru" ]]; then
    echo -e "\033[31mERROR\033[0m \"$DEST_BASE_DIR/Yaru\" folder already exist!"
    exit 1
fi

# If not exist, create "icons" folder destination
if ! [[ -d $DEST_BASE_DIR ]]; then
    echo "Create \"$DEST_BASE_DIR\" folder"
    mkdir $DEST_BASE_DIR
fi

# Copy icons pack to "icons" folder destination
echo "Copy Yaru icon pack to \"$DEST_BASE_DIR\""
cp -R $ICON_BASE_DIR/* $DEST_BASE_DIR
echo

# Process each Yaru icon folder
for YARU_DIR in "$DEST_BASE_DIR"/Yaru*; do
    [ -d "$YARU_DIR" ] || continue

    echo "$YARU_DIR : "

    echo " - Delete scalable* subfolders"
    rm -R $YARU_DIR/scalable*

    echo " - Delete icon-theme.cache file"
    rm $YARU_DIR/icon-theme.cache

    echo " - Replace Humanity with Adwaita inherits in index.theme"
    sed -i "s/Humanity/Adwaita/g" "$YARU_DIR/index.theme"

    echo " - Clean up scalable references in index.theme"
    # 1. Delete scalable*/* in "Directories"
    sed -i 's/,scalable.*\/.*//g' "$YARU_DIR/index.theme"
    # 2. Delete "[scalable*/*]" blocks
    sed -i '/\[scalable.*\/.*\]/,/^$/d' "$YARU_DIR/index.theme"
    # 3. Delete extra eventual commas
    sed -i 's/,,/,/g; s/,$//' "$YARU_DIR/index.theme"

    echo
done

echo "Done!"
