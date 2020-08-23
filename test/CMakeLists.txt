cmake_minimum_required (VERSION 3.6)

project(parser-test)


find_package(cmake-yaml-parser REQUIRED)

include(cyp)
set(yaml_file ${CMAKE_CURRENT_LIST_DIR}/test.yaml)
cyp_load(${yaml_file})

message(">>>>> CYP_VERSION=${CYP_VERSION}")

message(">>>>> YAML.4.COMPANIES.1.ID = ${YAML.4.COMPANIES.1.ID}")
message(">>>>> YAML.4.COMPANIES.2.NAME = ${YAML.4.COMPANIES.2.NAME}")
message(">>>>> YAML.4.COMPANIES.0.PRICE = ${YAML.4.COMPANIES.0.PRICE}")
message(">>>>> YAML.4.COMPANIES.1.ID = ${YAML.4.COMPANIES.1.ID}")
message(">>>>> YAML.4.COMPANIES.2.NAME = ${YAML.4.COMPANIES.2.NAME}")
