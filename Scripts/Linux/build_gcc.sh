#!/usr/bin/env bash
# ==============================================================================
# Generate AND Build SRVNet using GCC on Linux
# Builds Debug, Release, and Sanitizers (ASan, TSan, UBSan) for Samples and Tests.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

cd "${ROOT_DIR}"

echo "=============================================================================="
echo "[1/3] Building GCC Debug Configuration..."
echo "=============================================================================="
cmake -B Build/GCC -S . \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DSRVN_BUILD_SAMPLES=ON \
    -DSRVN_BUILD_TESTS=ON \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake --build Build/GCC --parallel "$(nproc)"

echo ""
echo "=============================================================================="
echo "[2/3] Building GCC Release Configuration..."
echo "=============================================================================="
cmake -B Build/GCC -S . \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_BUILD_TYPE=Release \
    -DSRVN_BUILD_SAMPLES=ON \
    -DSRVN_BUILD_TESTS=ON

cmake --build Build/GCC --parallel "$(nproc)"

echo ""
echo "=============================================================================="
echo "[3/3] Building GCC with Sanitizers..."
echo "=============================================================================="
cmake -B Build/GCC -S . \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DSRVN_BUILD_SAMPLES=ON \
    -DSRVN_BUILD_TESTS=ON \
    -DSRVN_ENABLE_ASAN=ON \
    -DSRVN_ENABLE_UBSAN=ON

cmake --build Build/GCC_San --parallel "$(nproc)"

echo ""
echo "=============================================================================="
echo "GCC Linux build matrix finished successfully!"
echo "Binaries located in Build/GCC*/"
echo "=============================================================================="
