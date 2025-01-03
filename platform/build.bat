@echo off
setlocal

:: Skip function (it's a label so don't execute it now)
goto :script

:: Check if a command exists
:command_exists
  where %1 >nul 2>nul
  if errorlevel 1 (
    echo %1 is not installed. Please install it and try again.
    exit /b 1
  )
  goto :eof

:: Continuation of script
:script

call :command_exists git

:: is this a git repo?
if not exist ".git" (
  echo This directory is not a git repository.
  exit /b 1
)

:: Are submodules updated?
if not exist ".git\modules" (
  echo.
  echo ================= Initializing ===================
  echo Updating submodules
  git submodule update --init --recursive --force
)

call :command_exists cmake

:: Are submodules configured?
if not exist "build\Makefile" (
  echo.
  echo ================= Configuring ===================
  mkdir build
  cd build
  cmake .. -G %*
  cd ..
)

:: Build
echo.
echo ================= Building ===================
cd build
cmake --build .
cd ..

echo.
echo NOTE: Don't forget to pass a cmake generator as argument to this script
echo See cmake --help for more info
echo ================= Done ===================