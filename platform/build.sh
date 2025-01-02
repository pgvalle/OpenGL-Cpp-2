#!/bin/bash

# command exists
command_exists() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed. Please install it and try again."
        exit 1
    fi
}
command_exists git

# is this a repo?
if [ ! -d ".git" ]; then
    echo "This directory is not a git repository."
    exit 1
fi

# submodules
if [ ! -d ".git/modules" ]; then
    echo -e "\n================= Initializing =================== and updating submodules"
    git submodule update --init --recursive
fi

command_exists cmake

# already configured
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

echo -e "\nNOTE: If the build failed, check if you have xorg/wayland dev packages installed."
echo "================= Done ==================="
