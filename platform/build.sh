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
if [ ! -d ".git/modules" ]; then
    echo -e "\n================= Initializing =================== and updating submodules"
    git submodule update --init --recursive --force
fi

command_exists cmake

# are submodules configured?
if [ ! -f "build/Makefile" ]; then
    echo -e "\n================= Configuring ==================="
    mkdir build
    cd build
    cmake ..
    cd ..
fi

# build
echo -e "\n================= Building ==================="
cd build
cmake --build .
cd ..

echo -e "\nNOTE: Don't forget to install xorg/wayland dev packages."
echo "================= Done ==================="
