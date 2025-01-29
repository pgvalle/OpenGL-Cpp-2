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

:: Make sure glfw is downloaded
echo ================= Initializing ===================
if not exist "vendor\glfw\.git" (
  git clone --branch 3.4 https://github.com/glfw/glfw vendor/glfw
)

call :command_exists cmake

if not exist "build" (
  mkdir build
)

:: Is project configured
if not exist "build\Makefile" (
  echo ================= Configuring ===================
  cmake -G %* -B build
)

:: Build
echo ================= Building ===================
cmake --build build

echo ================= Done ===================
echo USAGE: .\platform\build.bat cmake_generator_in_double_quotes
echo NOTE: Run cmake --help for more info on available generators.
