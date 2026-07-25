@echo off
setlocal
REM ==============================================================================
REM Generate Visual Studio 2022 Solution and Project Files ONLY (No Compilation)
REM ==============================================================================

cd /d "%~dp0"
cd ..

echo ===================================
echo     SRVN Solution Generator
echo ===================================
echo [1] Standard Solution
echo [2] Solution with ASan (AddressSanitizer)
echo [3] Clean Build Directory ^& Regenerate Standard
echo [4] Clean Build Directory ^& Regenerate ASan
echo ===================================
set /p CHOICE="Select an option (1-4): "

set BUILD_DIR=Build/VS2022
set COMMON_FLAGS=-B %BUILD_DIR% -S . -G "Visual Studio 17 2022" -A x64 -DSRVN_BUILD_SAMPLES=ON -DSRVN_BUILD_TESTS=ON

:: Clean step if requested
if "%CHOICE%"=="3" (
    echo.
    echo [INFO] Wiping existing build directory...
    if exist %BUILD_DIR% rmdir /s /q %BUILD_DIR%
)
if "%CHOICE%"=="4" (
    echo.
    echo [INFO] Wiping existing build directory...
    if exist %BUILD_DIR% rmdir /s /q %BUILD_DIR%
)

:: Run CMake generation based on choice
echo.
echo [INFO] Generating Visual Studio 2022 solution...

if "%CHOICE%"=="2" (
    cmake %COMMON_FLAGS% -DSRVN_ENABLE_ASAN=ON
) else if "%CHOICE%"=="4" (
    cmake %COMMON_FLAGS% -DSRVN_ENABLE_ASAN=ON
) else (
    cmake %COMMON_FLAGS%
)

:: Check for generation failure
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] CMake Visual Studio Project Generation Failed!
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo Visual Studio 2022 Solution generated successfully!
echo Open: %BUILD_DIR%\SRVNet.sln
echo ==============================================================================
pause