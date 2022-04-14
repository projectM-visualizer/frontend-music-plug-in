
add_library(ProjectM MODULE
    macos/iTunesAPI.cpp
    macos/iTunesAPI.h
    macos/iTunesVisualAPI.h
    getConfigFilename.cpp
    getConfigFilename.h
    iprojectM.hpp
    iprojectM.mm
    iprojectM_mac.mm
    )

set_target_properties(ProjectM PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/Resources/ProjectM-plugin-info.plist"
    )

target_link_libraries(ProjectM
    PRIVATE
    "-framework Cocoa"
    "-framework AppKit"
    "-framework CoreData"
    "-framework Foundation"
    libprojectM::static
    )
