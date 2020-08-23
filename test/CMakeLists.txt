cmake_minimum_required (VERSION 3.6)

project(parser-test)


find_package(cmake-yaml-parser REQUIRED)

include(cyp)
set(yaml_file ${CMAKE_CURRENT_LIST_DIR}/test.yaml)
cyp_load(${yaml_file})

message(">>>>> CYP_VERSION=${CYP_VERSION}")
message(">>>>> companies.1.id=${companies.1.id}")
message(">>>>> companies.1.name=${companies.1.name}")
message(">>>>> companies.1.price=${companies.1.price}")
message(">>>>> companies.2.id=${companies.2.id}")
message(">>>>> companies.2.name=${companies.2.name}")
message(">>>>> companies.2.price=${companies.2.price}")
message(">>>>> companies.3=${companies.3}")
message(">>>>> companies.4=${companies.4}")
message(">>>>> companies.5=${companies.5}")
message(">>>>> companies.6=${companies.6}")

message(">>>>> languages.1=${languages.1}")
message(">>>>> languages.2=${languages.2}")
message(">>>>> languages.3=${languages.3}")

message(">>>>> websites.YAML=${websites.YAML}")
message(">>>>> websites.Ruby=${websites.Ruby}")
message(">>>>> websites.Python=${websites.Python}")
message(">>>>> websites.Perl=${websites.Perl}")

message(">>>>> boolean.1=${boolean.1}")
message(">>>>> boolean.2=${boolean.2}")
