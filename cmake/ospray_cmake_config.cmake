## Copyright 2009-2019 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

# Version header
#<<<<<<< HEAD
CONFIGURE_FILE(
  ${CMAKE_CURRENT_SOURCE_DIR}/version.h.in
  ${CMAKE_CURRENT_BINARY_DIR}/version.h
  @ONLY
)

INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/version.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
#=======
#configure_file(
#  ${CMAKE_SOURCE_DIR}/ospray/version.h.in
#  ${CMAKE_BINARY_DIR}/ospray/version.h
#  @ONLY
#)
#
#install(FILES ${CMAKE_BINARY_DIR}/ospray/version.h
#  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ospray
#>>>>>>> master
#  COMPONENT devel
#)

# CMake config module
#<<<<<<< HEAD
SET(OSPRAY_MODULE_CONFIG_INPUT_DIR  ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/ospray_cmake_config)
SET(OSPRAY_MODULE_CONFIG_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/../cmake)
#=======
#set(OSPRAY_MODULE_CONFIG_INPUT_DIR  ${CMAKE_SOURCE_DIR}/cmake/ospray_cmake_config)
#set(OSPRAY_MODULE_CONFIG_OUTPUT_DIR ${CMAKE_BINARY_DIR}/cmake)
#>>>>>>> master

set(OSPRAY_MODULE_FILES
  osprayConfig.cmake
  osprayConfigVersion.cmake
  osprayUse.cmake
)

## find relative path to make package relocatable
# this is a bit involved to handle these cases:
#   - CMAKE_INSTALL_LIBDIR is overridden by the user
#   - CMAKE_INSTALL_LIBDIR contains multiple levels for Debian multiarch support
if (IS_ABSOLUTE "${CMAKE_INSTALL_PREFIX}")
  set(ABS_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
else()
  get_filename_component(ABS_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}" ABSOLUTE)
endif()

if (IS_ABSOLUTE "${OSPRAY_CMAKECONFIG_DIR}")
  MESSAGE(WARNING "CMAKE_INSTALL_LIBDIR needs to be a relative path!")
  set(ABS_CMAKECONFIG_DIR "${OSPRAY_CMAKECONFIG_DIR}")
else()
  set(ABS_CMAKECONFIG_DIR "${ABS_INSTALL_PREFIX}/${OSPRAY_CMAKECONFIG_DIR}")
endif()

file(RELATIVE_PATH OSPRAY_RELATIV_ROOT_DIR "${ABS_CMAKECONFIG_DIR}" "${ABS_INSTALL_PREFIX}" )


foreach(MODULE_FILE ${OSPRAY_MODULE_FILES})
  LIST(APPEND OSPRAY_MODULE_INSTALL_FILES
    ${OSPRAY_MODULE_CONFIG_OUTPUT_DIR}/${MODULE_FILE}
  )

  configure_file(
    ${OSPRAY_MODULE_CONFIG_INPUT_DIR}/${MODULE_FILE}.in
    ${OSPRAY_MODULE_CONFIG_OUTPUT_DIR}/${MODULE_FILE}
    @ONLY
  )
endforeach()

install(FILES
  ${OSPRAY_MODULE_INSTALL_FILES}
#<<<<<<< HEAD
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/FindTBB.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/clang.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/icc.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/ispc.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/gcc.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/msvc.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/../components/ospcommon/cmake/macros.cmake#NOTE(jda) - hack!
  ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/ospray_macros.cmake
#=======
#  ${CMAKE_SOURCE_DIR}/cmake/ospray_macros.cmake
#  ${CMAKE_SOURCE_DIR}/cmake/compiler/ispc.cmake
#>>>>>>> master
  DESTINATION ${OSPRAY_CMAKECONFIG_DIR}
  COMPONENT devel
)
