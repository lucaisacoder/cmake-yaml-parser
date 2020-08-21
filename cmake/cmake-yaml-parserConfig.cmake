set(_MODULE cmake-yaml-parser)
get_filename_component(_MODULE_PATH "${CMAKE_CURRENT_LIST_FILE}" PATH)

if(NOT TARGET ${_MODULE})
    include("${_MODULE_PATH}/${_MODULE}Targets.cmake")
endif()

message("${CMAKE_MODULE_PATH} ${_MODULE_PATH}/cmake")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${_MODULE_PATH})