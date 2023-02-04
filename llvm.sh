BUILD_SYSTEM=Ninja
BUILD_TAG=ninja

curl -L -o llvm-project-14.0.6.src.tar.xz https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.6/llvm-project-14.0.6.src.tar.xz

tar -xzvf llvm-project-14.0.6.src.tar.xz

mkdir llvm-build
mkdir -p llvm-install/software/llvm-14

ls -alh .
ls -alh ${PWD}/llvm-install/
ls -alh ${PWD}/llvm-install/software/
ls -alh ${PWD}/llvm-install/software/llvm-14


llvm-14-dir="${PWD}/llvm-install/software/llvm-14"

cd llvm-build

cmake ../llvm-project/llvm \
  -G$BUILD_SYSTEM -B ${BUILD_TAG}_build \
  -DCMAKE_OSX_ARCHITECTURES="x86_64;arm64" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_BUILD_WITH_INSTALL_RPATH=1 \
  -DCMAKE_INSTALL_PREFIX=$llvm-14-dir \
  -DLLVM_LOCAL_RPATH=$llvm-14-dir/lib \
  -DLLVM_ENABLE_WERROR=FALSE \
  -DLLVM_DEFAULT_TARGET_TRIPLE="arm64-apple-darwin22.3.0" \
  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;mlir;polly" \
  -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind;openmp" \
  -DLLVM_POLLY_LINK_INTO_TOOLS=ON \
  -DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON \
  -DLLVM_LINK_LLVM_DYLIB=ON \
  -DLLVM_ENABLE_EH=ON \
  -DLLVM_ENABLE_FFI=ON \
  -DLLVM_ENABLE_RTTI=ON \
  -DLLVM_INCLUDE_DOCS=OFF \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INSTALL_UTILS=ON \
  -DLLVM_ENABLE_Z3_SOLVER=OFF \
  -DLLVM_OPTIMIZED_TABLEGEN=ON \
  -DLLVM_TARGETS_TO_BUILD=all \
  -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
  -DLLDB_ENABLE_PYTHON=OFF \
  -DLLDB_ENABLE_LUA=OFF \
  -DLLDB_ENABLE_LZMA=OFF \
  -DLIBOMP_INSTALL_ALIASES=OFF \
  -DCLANG_PYTHON_BINDINGS_VERSIONS=3.11.1 \
  -DLLVM_CREATE_XCODE_TOOLCHAIN=OFF \
  -DPACKAGE_VENDOR=Mehdi \
  -DBUG_REPORT_URL=https://lashar.net \
  -DCLANG_VENDOR_UTI=org.https://lashar.net \
  -DFFI_INCLUDE_DIR=$(xcrun -sdk macosx --show-sdk-path)/usr/include/ffi \
  -DFFI_LIBRARY_DIR=$(xcrun -sdk macosx --show-sdk-path)/usr/lib \
  -DLLVM_BUILD_LLVM_C_DYLIB=ON \
  -DLLVM_ENABLE_LIBCXX=ON \
  -DLIBCXX_INSTALL_LIBRARY_DIR=$llvm-14-dir/lib/c++ \
  -DLIBCXXABI_INSTALL_LIBRARY_DIR=$llvm-14-dir/lib/c++ \
  -DDEFAULT_SYSROOT=$(xcrun -sdk macosx --show-sdk-path) \
  -DLLVM_USE_LINKER=ld \
  -DCMAKE_LINKER=ld \
  -DRUNTIMES_CMAKE_ARGS="-DCMAKE_INSTALL_RPATH=$llvm-14-dir -DCMAKE_LINKER=ld" \
  -DBUILTINS_CMAKE_ARGS=" -DCMAKE_LINKER=ld" \
  -Wno-dev
