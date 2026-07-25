@echo off
setlocal
REM ==============================================================================
REM Generate AND Build SRVNet using MSVC (Debug, Release, ASan)
REM Builds all samples and tests.
REM ==============================================================================

cd /d "%~dp0"
cd ..

echo ==============================================================================
echo [1/3] Generating Visual Studio 2022 Solution (Debug ^& Release)...
echo ==============================================================================
cmake -B Build/MSVC -S . -G "Visual Studio 17 2022" -A x64 ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON ^
    -DSRVN_WARNINGS_AS_ERRORS=OFF

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Generation failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo [2/3] Compiling MSVC Debug Configuration (Samples ^& Tests)...
echo ==============================================================================
cmake --build Build/MSVC --config Debug --parallel

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] MSVC Debug build failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo Compiling MSVC Release Configuration (Samples ^& Tests)...
echo ==============================================================================
cmake --build Build/MSVC --config Release --parallel

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] MSVC Release build failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo [3/3] Generating & Compiling MSVC AddressSanitizer (ASan) Build...
echo ==============================================================================
cmake -B Build/MSVC_ASan -S . -G "Visual Studio 17 2022" -A x64 ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON ^
    -DSRVN_ENABLE_ASAN=ON

if %ERRORLEVEL% EQU 0 (
    cmake --build Build/MSVC_ASan --config Debug --parallel
)

echo.
echo ==============================================================================
echo MSVC Build completed successfully!
echo Binaries located in: Build\MSVC\Binaries\
echo ==============================================================================
pause
