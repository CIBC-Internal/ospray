## Copyright 2009-2020 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

set(COMPONENT_NAME ospray)

set(COMPONENT_PATH ${INSTALL_DIR_ABSOLUTE})
if (INSTALL_IN_SEPARATE_DIRECTORIES)
  set(COMPONENT_PATH ${INSTALL_DIR_ABSOLUTE}/${COMPONENT_NAME})
endif()

ExternalProject_Add(${COMPONENT_NAME}
  PREFIX ${COMPONENT_NAME}
  DOWNLOAD_COMMAND ""
  STAMP_DIR ${COMPONENT_NAME}/stamp
  SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..
  BINARY_DIR ${COMPONENT_NAME}/build
  LIST_SEPARATOR | # Use the alternate list separator
  CMAKE_ARGS
    -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX:PATH=${COMPONENT_PATH}
    -DCMAKE_INSTALL_INCLUDEDIR=${CMAKE_INSTALL_INCLUDEDIR}
    -DCMAKE_INSTALL_LIBDIR=${CMAKE_INSTALL_LIBDIR}
    -DCMAKE_INSTALL_DOCDIR=${CMAKE_INSTALL_DOCDIR}
    -DCMAKE_INSTALL_BINDIR=${CMAKE_INSTALL_BINDIR}
    -Dglm_DIR:PATH=${glm_DIR}
    -DOSPRAY_APPS_ENABLE_GLM=ON
    -DOSPRAY_BUILD_ISA=ALL
    -DOSPRAY_MODULE_BILINEAR_PATCH=${BUILD_OSPRAY_CI_EXTRAS}
    -DOSPRAY_MODULE_DENOISER=${BUILD_OIDN}
    -DOSPRAY_INSTALL_DEPENDENCIES=${INSTALL_DEPENDENCIES}
    -DOSPRAY_STRICT_BUILD=${BUILD_OSPRAY_CI_EXTRAS}
    -DOSPRAY_WARN_AS_ERRORS=${BUILD_OSPRAY_CI_EXTRAS}
    $<$<BOOL:${DOWNLOAD_ISPC}>:-DISPC_EXECUTABLE=${ISPC_PATH}>
    $<$<BOOL:${DOWNLOAD_TBB}>:-DRKCOMMON_TBB_ROOT=${TBB_PATH}>
  BUILD_COMMAND ${DEFAULT_BUILD_COMMAND}
  BUILD_ALWAYS OFF
)

ExternalProject_Add_StepDependencies(${COMPONENT_NAME}
configure
  glm
  rkcommon
  embree
  openvkl
  $<$<BOOL:${BUILD_GLFW}>:glfw>
  $<$<BOOL:${DOWNLOAD_ISPC}>:ispc>
  $<$<BOOL:${BUILD_OIDN}>:oidn>
)

list(APPEND CMAKE_PREFIX_PATH ${COMPONENT_PATH})
string(REPLACE ";" "|" CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH}")
