
# The actual bundle directory, including the proper iTunes plug-in dir.
set(PROJECTM_PLUGIN_BUNDLE_DIR "Library/iTunes/iTunes Plug-ins/ProjectM.bundle")

install(TARGETS ProjectM
    LIBRARY DESTINATION "${PROJECTM_PLUGIN_BUNDLE_DIR}/Contents/MacOS"
    COMPONENT MusicPlugin
    )

install(FILES src/Resources/ProjectM-plugin-info.plist
    DESTINATION "${PROJECTM_PLUGIN_BUNDLE_DIR}/Contents/"
    RENAME Info.plist
    COMPONENT MusicPlugin
    )

install(FILES src/Resources/PkgInfo
    DESTINATION "${PROJECTM_PLUGIN_BUNDLE_DIR}/Contents/"
    COMPONENT MusicPlugin
    )

foreach(preset_dir ${PRESET_DIRS})
    install(DIRECTORY ${preset_dir}
        DESTINATION "${PROJECTM_PLUGIN_BUNDLE_DIR}/Contents/Resources/presets/"
        COMPONENT MusicPlugin
        PATTERN *.md EXCLUDE
        )
endforeach()

configure_file(install-codesign.cmake.in "${CMAKE_BINARY_DIR}/install-codesign.cmake" @ONLY)
install(SCRIPT "${CMAKE_BINARY_DIR}/install-codesign.cmake"
    COMPONENT MusicPlugin
    )

# Build PKG installer with CPack
set(CPACK_GENERATOR "productbuild")
set(CPACK_COMPONENTS_ALL "MusicPlugin")
set(CPACK_PACKAGE_NAME "ProjectM-MusicPlugin")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${PROJECT_VERSION}")
set(CPACK_PKGBUILD_IDENTITY_NAME "${CODESIGN_IDENTITY_INSTALLER}")
set(CPACK_PRODUCTBUILD_IDENTITY_NAME "${CODESIGN_IDENTITY_INSTALLER}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY /)
set(CPACK_PACKAGING_INSTALL_PREFIX /)

# Installer texts
set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/src/Resources/welcome.txt")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/src/Resources/readme.txt")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/src/Resources/lgpl-2.1.rtf")

# Install domain settings only have effect when using CMake 3.23 or higher!
if(CMAKE_VERSION VERSION_LESS 3.23)
    message(AUTHOR_WARNING "Using a CMake version less than 3.23 will prevent a user to install the PKG in the home directory!")
endif()

set(CPACK_PRODUCTBUILD_DOMAINS TRUE)
set(CPACK_PRODUCTBUILD_DOMAINS_ANYWHERE FALSE)
set(CPACK_PRODUCTBUILD_DOMAINS_USER TRUE)
set(CPACK_PRODUCTBUILD_DOMAINS_ROOT TRUE)

include(CPack)

# Workaround for a bug in CMake that results in creating an empty installer
# https://gitlab.kitware.com/cmake/cmake/-/issues/18201
cpack_add_component(MusicPlugin
    DISPLAY_NAME "projectM Music Plug-in"
    REQUIRED
    )
