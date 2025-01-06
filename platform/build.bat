@echo off
setlocal

:: Skip function (it's a label so don't execute it now)
goto :script

:: Function to check if a command exists
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
echo ================= Initializing ===================
git submodule foreach "git reset --hard"
git submodule update --init --recursive

call :command_exists cmake

if not exist "build" (
  mkdir build
)

cd build

:: Is project configured
if not exist "build\Makefile" (
  echo ================= Configuring ===================
  cmake .. -G %*
)

:: Build
echo ================= Building ===================
cmake --build .

echo ================= Done ===================
echo USAGE: .\platform\build.bat generator_in_quotes_or_double_quotes
echo NOTE: Run cmake --help for more info on available generators.
