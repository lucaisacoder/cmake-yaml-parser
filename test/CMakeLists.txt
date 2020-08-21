cmake_minimum_required (VERSION 3.6)

project(parser-test)


find_package(cmake-yaml-parser REQUIRED)

include(cyp-test)
cyp_test()
