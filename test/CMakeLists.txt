cmake_minimum_required (VERSION 3.6)

project(parser-test)


find_package(cmake-yaml-parser REQUIRED)

include(cyp)
set(yaml_file ${CMAKE_CURRENT_LIST_DIR}/test.yaml)
cyp_load(${yaml_file})

message(">>>>> PARSER_VERSION=${PARSER_VERSION}")
