@echo off
setlocal


REM command exists
:command_exists
where %1 >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo %1 is not installed. Please install it and try again.
    exit /b 1
)
exit /b 0

REM git
call :command_exists git

REM Directory is a git repository
if not exist ".git" (
    echo This directory is not a git repository.
    exit /b 1
)

REM Check and initialize submodules
if not exist ".git\modules" (
    echo.
    echo ================= Initializing ===================
    echo Updating submodules
    git submodule update --init --recursive
)

REM CMake
call :command_exists cmake

REM Check if the project is already configured
if not exist "build\Makefile" (
    echo.
    echo ================= Configuring ===================
    mkdir build
    cd build
    cmake ..
    cd ..
)

REM Build
echo.
echo ================= Building ===================
cd build
cmake --build .
cd ..

echo.
echo ================= Done ===================