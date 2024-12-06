cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(vrtour_app VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Positioning Location Sql Network)

include(FetchContent)

qt_standard_project_setup(REQUIRES 6.5)


set(app_icon_resource "${CMAKE_CURRENT_SOURCE_DIR}/ressources.rc")

qt_add_executable(appvrtour_app
    main.cpp
    ${app_icon_resource}
)

file(GLOB_RECURSE
    IMAGES
    LIST_DIRECTORIES FALSE
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    vrtour_qml/img/*.png vrtour_qml/img/*.jpg vrtour_qml/img/*.jpeg
)

message(STATUS "Globed following files: ${IMAGES}")

qt_add_qml_module(appvrtour_app
    URI vrtour_app
    VERSION 1.0
    QML_FILES
        vrtour_qml/Main.qml
        vrtour_qml/VRT_TabBar.qml
        RESOURCES  ${IMAGES}
        QML_FILES vrtour_qml/Const.js
        QML_FILES vrtour_qml/VRT_HomePage.qml vrtour_qml/VRT_Page.qml
        QML_FILES vrtour_qml/VRT_PlaceCard.qml
        SOURCES vrt_database.h vrt_database.cpp
        SOURCES vrt_place.h vrt_place.cpp
        SOURCES vrt_downloader.h vrt_downloader.cpp
)

if (ANDROID)
    message(STATUS "Building for android")
    FetchContent_Declare(
      android_openssl
      DOWNLOAD_EXTRACT_TIMESTAMP true
      URL      https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
#      URL_HASH MD5=c97d6ad774fab16be63b0ab40f78d945 #optional
    )

    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)

    add_android_openssl_libraries(appvrtour_app)

endif()

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appvrtour_app PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appvrtour_app
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appvrtour_app
    PRIVATE Qt6::Quick Qt6::Positioning Qt6::Location Qt6::Sql Qt6::Network
)

include(GNUInstallDirs)
install(TARGETS appvrtour_app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


