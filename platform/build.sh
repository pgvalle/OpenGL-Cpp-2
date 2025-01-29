#!/bin/bash

command_exists() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed. Please install it and try again."
        exit 1
    fi
}

command_exists git

# make sure glfw is downloaded
echo "================= Initializing ==================="
if [ ! -d "vendor/glfw/.git" ]; then
    git clone --branch 3.4 https://github.com/glfw/glfw vendor/glfw
fi

command_exists cmake

# Is the project configured?
if [ ! -f "build/Makefile" ]; then
    echo "================= Configuring ==================="
    cmake -B build
fi

# build
echo "================= Building ==================="
cmake --build build

echo "================= Done ==================="
echo "NOTE: Don't forget to install xorg/wayland dev packages."