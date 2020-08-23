cmake_minimum_required (VERSION 3.6)

project(cmake-yaml-parser VERSION 0.0.1.1)

add_library(${PROJECT_NAME} INTERFACE)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(EXPORT ${PROJECT_NAME}Targets DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

# TODO: folder list
list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp_python")
list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp_parser")
list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp_test")
#list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp_xxx")


# install folder list
foreach(_dir ${_cyp_dirs})
    install(DIRECTORY ${_dir} DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME} PATTERN "*.cmake" PATTERN "*.py")
    set(__cyp_dirs "${__cyp_dirs} ${_dir}")
endforeach()

# install config file
set(_cmake_config_file "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake")
set(_cmake_config_file_content "
set(_MODULE \"${PROJECT_NAME}\")
get_filename_component(_MODULE_PATH \"\${CMAKE_CURRENT_LIST_FILE}\" PATH)

if(NOT TARGET \${_MODULE})
    include(\"\${_MODULE_PATH}/\${_MODULE}Targets.cmake\")
endif()

list(APPEND CMAKE_MODULE_PATH \${_MODULE_PATH})
list(APPEND CMAKE_MODULE_PATH ${__cyp_dirs})
")
file(WRITE ${_cmake_config_file} ${_cmake_config_file_content})
install(FILES ${_cmake_config_file} DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})


# package
set(CPACK_GENERATOR "TGZ")
set(CPACK_SOURCE_GENERATOR "TGZ")

set(CPACK_DEBIAN_PACKAGE_MAINTAINER "lucas.hsueh@hotmail.com")

set(CPACK_PACKAGE_VERSION           "${CMAKE_PROJECT_VERSION}")
set(CPACK_PACKAGE_VERSION_MAJOR     "${CMAKE_PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR     "${CMAKE_PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH     "${CMAKE_PROJECT_VERSION_PATCH}")

set(CPACK_PACKAGE_DESCRIPTION_FILE  "${CMAKE_CURRENT_LIST_DIR}/README.rst")
set(CPACK_RESOURCE_FILE_LICENSE     "${CMAKE_CURRENT_LIST_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README      "${CMAKE_CURRENT_LIST_DIR}/README.rst")
set(CPACK_RESOURCE_FILE_WELCOME     "${CMAKE_CURRENT_LIST_DIR}/README.rst")

set(CPACK_SOURCE_IGNORE_FILES       "${CMAKE_SOURCE_DIR}/build/;${CMAKE_SOURCE_DIR}/.git/")

include(CPack)