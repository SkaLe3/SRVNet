@echo off
setlocal
REM ==============================================================================
REM Generate AND Build SRVNet using GCC (MinGW) on Windows
REM Builds Debug, Release, and Sanitizer configurations for Samples and Tests.
REM ==============================================================================

cd /d "%~dp0"
cd ..

echo ==============================================================================
echo [1/3] Generating MinGW / GCC Build Files (Debug)...
echo ==============================================================================
cmake -B Build/GCC -S . -G "MinGW Makefiles" ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON

if %ERRORLEVEL% NEQ 0 (
    echo [NOTE] MinGW Makefiles generator unavailable, trying Ninja...
    cmake -B Build/GCC -S . -G "Ninja" ^
        -DCMAKE_CXX_COMPILER=g++ ^
        -DCMAKE_BUILD_TYPE=Debug ^
        -DSRVN_BUILD_SAMPLES=ON ^
        -DSRVN_BUILD_TESTS=ON
)

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] GCC configuration failed. Please verify MinGW/g++ is in PATH.
    pause
    exit /b %ERRORLEVEL%
)

cmake --build Build/GCC --parallel

echo.
echo ==============================================================================
echo [2/3] Generating ^& Building GCC Release Configuration...
echo ==============================================================================
cmake -B Build/GCC -S . -G "MinGW Makefiles" ^
    -DCMAKE_CXX_COMPILER=g++ ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON

cmake --build Build/GCC --parallel

echo.
echo ==============================================================================
echo [3/3] Generating ^& Building GCC with AddressSanitizer (ASan)...
echo ==============================================================================
cmake -B Build/GCC_San -S . -G "MinGW Makefiles" ^
    -DCMAKE_CXX_COMPILER=g++ ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON ^
    -DSRVN_ENABLE_ASAN=ON ^
    -DSRVN_ENABLE_UBSAN=ON

if %ERRORLEVEL% EQU 0 (
    cmake --build Build/GCC_San --parallel
)

echo.
echo ==============================================================================
echo GCC Windows build completed.
echo ==============================================================================
pause
