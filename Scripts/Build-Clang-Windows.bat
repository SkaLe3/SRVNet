@echo off
setlocal
REM ==============================================================================
REM Generate AND Build SRVNet using Clang on Windows (clang-cl / ClangCL)
REM Builds Debug, Release, and Sanitizer configurations for Samples and Tests.
REM ==============================================================================

cd /d "%~dp0"
cd ..

echo ==============================================================================
echo [1/3] Generating Visual Studio 2022 Solution with ClangCL toolset...
echo ==============================================================================
cmake -B Build/Clang -S . -G "Visual Studio 17 2022" -A x64 -T ClangCL ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON

if %ERRORLEVEL% NEQ 0 (
    echo [NOTE] Visual Studio ClangCL toolset not found, trying Ninja with clang-cl...
    cmake -B Build/Clang -S . -G "Ninja" ^
        -DCMAKE_CXX_COMPILER=clang-cl ^
        -DSRVN_BUILD_SAMPLES=ON ^
        -DSRVN_BUILD_TESTS=ON
)

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Clang configuration failed. Please verify Clang is installed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================================================
echo [2/3] Compiling Clang Debug ^& Release Configurations...
echo ==============================================================================
cmake --build Build/Clang --config Debug --parallel
cmake --build Build/Clang --config Release --parallel

echo.
echo ==============================================================================
echo [3/3] Generating ^& Building Clang with AddressSanitizer (ASan)...
echo ==============================================================================
cmake -B Build/Clang_San -S . -G "Ninja" ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -DSRVN_BUILD_SAMPLES=ON ^
    -DSRVN_BUILD_TESTS=ON ^
    -DSRVN_ENABLE_ASAN=ON ^
    -DSRVN_ENABLE_UBSAN=ON

if %ERRORLEVEL% EQU 0 (
    cmake --build Build/Clang_San --parallel
)

echo.
echo ==============================================================================
echo Clang Windows build process finished.
echo ==============================================================================
pause
