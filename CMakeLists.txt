## Copyright 2009-2019 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.1)

##############################################################
# Language setup
##############################################################

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

set(CMAKE_C_STANDARD   99)
set(CMAKE_CXX_STANDARD 11)

set(CMAKE_C_STANDARD_REQUIRED   ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

##############################################################
# Establish project
##############################################################

include(cmake/ospray_version.cmake)

project(OSPRay VERSION ${OSPRAY_VERSION} LANGUAGES C CXX)

##############################################################
# CMake modules and macro files
##############################################################
#<<<<<<< HEAD
#IF (OSPRAY_ENABLE_APPS)
  #ADD_SUBDIRECTORY(apps)
#ENDIF()

##############################################################
# OSPRay modules
# modules are OPTTIONAL and EXTERNAL packages that
# users can link into ospray. they can use any and all pieces of
# ospray but obviously no ospray parts may ever depend on a
# module (which by definition is OPTIONAL) - so those go
# AT THE BACK, only AFTER ALL OTHER PARTS OF OSPRAY ARE BUILT
##############################################################
#ADD_SUBDIRECTORY(modules)
#=======

list(APPEND CMAKE_MODULE_PATH
  ${PROJECT_SOURCE_DIR}/cmake
  ${PROJECT_SOURCE_DIR}/cmake/compiler
)
#>>>>>>> master

include(ospray_macros)
include(ospray_options)
include(package)
include(ispc)

if (OSPRAY_INSTALL_DEPENDENCIES)
  include(ospray_redistribute_deps)
endif()

##############################################################
# Add library and executable targets
##############################################################
#<<<<<<< HEAD
OPTION(OSPRAY_ENABLE_TARGET_CLANGFORMAT
       "Enable 'format' target, requires clang-format too" OFF)
INCLUDE(clang-format)

# create a configure file that both ospray and ispc can read the cmake config
# from needs to be at the end, after all cache variables have been set
CONFIGURE_FILE(ospray/common/OSPConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/OSPConfig.h)
INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/OSPConfig.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ospray
  COMPONENT devel
)

#######################
# CIBC External stuff #
#######################
SET(SCI_OSPRAY_INCLUDE "${CMAKE_CURRENT_SOURCE_DIR}" CACHE INTERNAL "Ospray include directories.")

set(SCI_OSPRAY_LIBRARY_DIR ${CMAKE_CURRENT_BINARY_DIR})
#set(OSPRAY_USE_FILE "${CMAKE_CURRENT_SOURCE_DIR}/UseOspray.cmake")

configure_file(OsprayConfig.cmake.in "${CMAKE_CURRENT_BINARY_DIR}/OsprayConfig.cmake" @ONLY)
export(TARGETS ${SCI_OSPRAY_LIBRARY} FILE OsprayExports.cmake)


# has to be last
INCLUDE(CPack)
#=======

## Main OSPRay library ##
add_subdirectory(ospray)

## OSPRay sample apps ##
if (OSPRAY_ENABLE_APPS)
  add_subdirectory(apps)
endif()

## Modules ##
if (OSPRAY_ENABLE_MODULES)
  add_subdirectory(modules)
endif()

## Testing ##
if (OSPRAY_APPS_TESTING)
  add_subdirectory(test_image_data)
endif()

## Clang-format target ##
if (OSPRAY_ENABLE_TARGET_CLANGFORMAT)
  include(clang-format)
endif()

# Must be last
include(CPack)
#>>>>>>> master
