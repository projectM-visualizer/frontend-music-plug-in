cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)

project(projectM-Apple-Music-PlugIn
    VERSION 3.0
    LANGUAGES OBJC C CXX
    )

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    message(FATAL_ERROR "This plug-in only builds on macOS.")
endif()

set(CODESIGN_IDENTITY_BUNDLE "-" CACHE STRING "Code signing identity for signing the plug-in bundle. Default is \"-\" (automatic signing).")
set(CODESIGN_IDENTITY_INSTALLER "" CACHE STRING "Code signing identity for signing the installer package. Default is \"\" (no signing).")
set(PRESET_DIRS "" CACHE STRING "List of paths with presets. Required.")
set(TEXTURE_DIR "" CACHE STRING "Path with default textures. Required.")

if(PRESET_DIRS STREQUAL "")
    message(FATAL_ERROR "PRESET_DIRS must be set to at least one preset dir.")
endif()

if(TEXTURE_DIR STREQUAL "")
    message(FATAL_ERROR "TEXTURE_DIR must be set to a texture dir.")
endif()

find_package(projectM4 REQUIRED COMPONENTS Playlist)

add_subdirectory(src)

include(packaging.cmake)