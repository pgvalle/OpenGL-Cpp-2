#!/bin/bash

command_exists() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed. Please install it and try again."
        exit 1
    fi
}
command_exists git

# is this a git repo?
if [ ! -d ".git" ]; then
    echo "This directory is not a git repository."
    exit 1
fi

# are submodules updated?
echo "================= Initializing ==================="
git submodule foreach "git reset --hard"
git submodule update --init --recursive

command_exists cmake

mkdir -p build
cd build

# Is the project configured?
if [ ! -f "build/Makefile" ]; then
    echo "================= Configuring ==================="
    cmake ..
fi

# build
echo "================= Building ==================="
cmake --build .

echo "================= Done ==================="
echo "NOTE: Don't forget to install xorg/wayland dev packages."