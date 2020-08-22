cmake_minimum_required (VERSION 3.6)

project(cmake-yaml-parser)

add_library(${PROJECT_NAME} INTERFACE)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(EXPORT ${PROJECT_NAME}Targets DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

# TODO: folder list
list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp-parser")
list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp-test")
#list(APPEND _cyp_dirs "${CMAKE_CURRENT_LIST_DIR}/cyp-xxx")


# install folder list
foreach(_dir ${_cyp_dirs})
    install(DIRECTORY ${_dir} DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME} PATTERN "*.cmake")
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