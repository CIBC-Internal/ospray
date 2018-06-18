#!/bin/sh
## ======================================================================== ##
## Copyright 2016-2018 Intel Corporation                                    ##
##                                                                          ##
## Licensed under the Apache License, Version 2.0 (the "License");          ##
## you may not use this file except in compliance with the License.         ##
## You may obtain a copy of the License at                                  ##
##                                                                          ##
##     http://www.apache.org/licenses/LICENSE-2.0                           ##
##                                                                          ##
## Unless required by applicable law or agreed to in writing, software      ##
## distributed under the License is distributed on an "AS IS" BASIS,        ##
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. ##
## See the License for the specific language governing permissions and      ##
## limitations under the License.                                           ##
## ======================================================================== ##

mkdir bin_local
cd bin_local
rm -rf *

wget https://github.com/embree/embree/releases/download/v3.2.0/embree-3.2.0.x86_64.macosx.tar.gz
tar -xvf embree-3.2.0.x86_64.macosx.tar.gz

cd ../..
wget https://downloads.sourceforge.net/project/ispcmirror/v1.9.2/ispc-v1.9.2-osx.tar.gz --no-check-certificate && tar -xvf ispc-v1.9.2-osx.tar.gz && rm ispc-v1.9.2-osx.tar.gz
cd ospray/bin_local

wget https://github.com/01org/tbb/releases/download/2018_U4/tbb2018_20180411oss_mac.tgz
tar -xvf tbb2018_20180411oss_mac.tgz

cmake \
-D embree_DIR:PATH=bin_local/embree-3.2.0.x86_64.macosx \
-D OSPRAY_TASKING_SYSTEM=TBB \
-D TBB_ROOT:PATH=bin_local/tbb2018_20180411oss \
-D OSPRAY_ENABLE_TESTING=ON \
-D OSPRAY_SG_CHOMBO=OFF \
-D OSPRAY_SG_OPENIMAGEIO=OFF \
-D OSPRAY_SG_VTK=OFF \
..

make -j 4 && make test
