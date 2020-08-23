include(cyp-basic)


macro(cyp_init _filename)
    find_package(PythonInterp REQUIRED)
    set(_cyp_parser_script_name "cyp-parser.py")
    find_file(_cyp_parser_script
        NAMES "${_cyp_parser_script_name}"
        PATHS ${CMAKE_PREFIX_PATH} ${CMAKE_MODULE_PATH})
    if(NOT EXISTS ${_cyp_parser_script})
        cyp_print("no such a file: ${_cyp_parser_script_name}")
        return()
    endif()
    execute_process(
        COMMAND python ${_cyp_parser_script} ${_filename}
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        RESULT_VARIABLE _result
        OUTPUT_VARIABLE _output)
    if(NOT ${_result} STREQUAL "0")
        cyp_print("fail to run : ${_cyp_parser_script}")
        return()
    endif()
    cyp_print("${_output}")
endmacro(cyp_init)
