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

mkdir build
cd build
rm -rf *

#wget https://github.com/embree/embree/releases/download/v3.2.0/embree-3.2.0.x86_64.macosx.tar.gz
#tar -xvf embree-3.2.0.x86_64.macosx.tar.gz

#wget https://downloads.sourceforge.net/project/ispcmirror/v1.9.2/ispc-v1.9.2-osx.tar.gz && tar -xvf ispc-v1.9.2-osx.tar.gz && rm ispc-v1.9.2-osx.tar.gz

#wget https://github.com/01org/tbb/releases/download/2018_U4/tbb2018_20180411oss_mac.tgz
#tar -xvf tbb2018_20180411oss_mac.tgz

#export PATH="$TRAVIS_BUILD_DIR/build/ispc-v1.9.2-osx/:$PATH"

cmake ../scripts/superbuild

make -j4 && make test
