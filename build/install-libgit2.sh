#!/bin/sh
set -x

# Set temp environment vars
export LIBGIT2REPO=https://github.com/libgit2/libgit2.git
export LIBGIT2BRANCH=v0.24.0
export LIBGIT2PATH=/tmp/libgit2
export PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/tmp/libgit2/install/lib/pkgconfig:/tmp/openssl/install/lib/pkgconfig:/tmp/libssh2/build/src"

# Compile & Install libgit2 (v0.23)
git clone -b ${LIBGIT2BRANCH} --depth 1 -- ${LIBGIT2REPO} ${LIBGIT2PATH}

mkdir -p ${LIBGIT2PATH}/build
cd ${LIBGIT2PATH}/build
cmake -DTHREADSAFE=ON \
      -DBUILD_CLAR=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_C_FLAGS=-fPIC \
      -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
      -DCMAKE_INSTALL_PREFIX=../install \
      ..
cmake --build . --target install

# Cleanup
# rm -r ${LIBGIT2PATH}
