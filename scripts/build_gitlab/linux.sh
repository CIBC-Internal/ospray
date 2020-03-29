#!/bin/bash
## Copyright 2015-2019 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

mkdir build
cd build
rm -rf *

#wget https://github.com/embree/embree/releases/download/v3.8.0/embree-3.8.0.x86_64.linux.tar.gz
#tar -xvf embree-3.8.0.x86_64.linux.tar.gz

#wget https://downloads.sourceforge.net/project/ispcmirror/v1.9.2/ispc-v1.9.2-linux.tar.gz && tar -xvf ispc-v1.9.2-linux.tar.gz && rm ispc-v1.9.2-linux.tar.gz

#export PATH="$TRAVIS_BUILD_DIR/build/ispc-v1.9.2-linux/:$PATH"

# NOTE(jda) - Some Linux OSs need to have lib/ on LD_LIBRARY_PATH at build time
export LD_LIBRARY_PATH=`pwd`/install/lib:${LD_LIBRARY_PATH}

cmake --version

cmake -L \
  -D embree_DIR:PATH=build/embree-3.8.0.x86_64.linux \
  -D OSPRAY_TASKING_SYSTEM=Internal \
  -D OSPRAY_BUILD_ISA=ALL \
  -D OSPRAY_ENABLE_TESTING=ON \
  -D OSPRAY_AUTO_DOWNLOAD_TEST_IMAGES=OFF \
  -D OSPRAY_MODULE_BILINEAR_PATCH=ON \
  -D OSPRAY_SG_CHOMBO=OFF \
  -D OSPRAY_SG_OPENIMAGEIO=OFF \
  -D OSPRAY_SG_VTK=OFF \
  -D CMAKE_INSTALL_LIBDIR=lib \
  -D BUILD_OSPRAY_CI_TESTS=ON \
  -D BUILD_EMBREE_FROM_SOURCE=OFF \
  -D INSTALL_IN_SEPARATE_DIRECTORIES=OFF \
  "$@" \
   ../scripts/superbuild

cmake --build .
