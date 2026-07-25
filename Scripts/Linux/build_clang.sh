 #!/usr/bin/env bash
# ==============================================================================
# Generate AND Build SRVNet using Clang on Linux
# Builds Debug, Release, and Sanitizers (ASan, TSan, UBSan, MSan) for Samples and Tests.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

cd "${ROOT_DIR}"

echo "=============================================================================="
echo "[1/5] Building Clang Debug Configuration..."
echo "=============================================================================="
cmake -B Build/Clang -S . \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DSRVN_BUILD_SAMPLES=ON \
    -DSRVN_BUILD_TESTS=ON \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake --build Build/Clang --parallel "$(nproc)"

echo ""
echo "=============================================================================="
echo "[2/5] Building Clang Release Configuration..."
echo "=============================================================================="
cmake -B Build/Clang -S . \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_BUILD_TYPE=Release \
    -DSRVN_BUILD_SAMPLES=ON \
    -DSRVN_BUILD_TESTS=ON

cmake --build Build/Clang --parallel "$(nproc)"

echo ""
echo "=============================================================================="
echo "[3/5] Building Clang with Sanitizers ..."
echo "=============================================================================="
cmake -B Build/Clang_San -S . \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_BUILD_TYPE=Debug \
    -DSRVN_BUILD_SAMPLES=ON \
    -DSRVN_BUILD_TESTS=ON \
    -DSRVN_ENABLE_ASAN=ON \
    -DSRVN_ENABLE_UBSAN=ON

cmake --build Build/Clang_San --parallel "$(nproc)"

echo ""
echo "=============================================================================="
echo "Clang Linux build matrix finished!"
echo "Binaries located in Build/Clang*/"
echo "=============================================================================="
