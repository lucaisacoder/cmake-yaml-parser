include(cyp-basic)


macro(cyp_init _filename)
    find_package(PythonInterp REQUIRED)
    set(_cyp_parser_script_name "cyp-parser.py")
    set(_output_filename "cyp-inc.cmake")

    find_file(_cyp_output_filename
        NAMES "${_output_filename}"
        PATHS ${CMAKE_CURRENT_SOURCE_DIR})
    message("${_cyp_output_filename}")
    if(EXISTS ${_cyp_output_filename})
        execute_process(
            COMMAND rm -rf ${_output_filename}
            WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
    endif()

    find_file(_cyp_parser_script
        NAMES "${_cyp_parser_script_name}"
        PATHS ${CMAKE_PREFIX_PATH} ${CMAKE_MODULE_PATH})
    if(NOT EXISTS ${_cyp_parser_script})
        cyp_print("no such a file: ${_cyp_parser_script_name}")
        return()
    endif()

    execute_process(
        COMMAND python ${_cyp_parser_script} ${_filename} ${_output_filename}
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        RESULT_VARIABLE _result
        OUTPUT_VARIABLE global_file_content)
    if(NOT ${_result} STREQUAL "0")
        cyp_print("fail to run : ${_cyp_parser_script}")
        return()
    endif()
    cyp_print("python ${_cyp_parser_script} ${_filename} ${_output_filename}")
    cyp_print("${global_file_content}")

    find_file(_cyp_output_filename
        NAMES "${_output_filename}"
        PATHS ${CMAKE_CURRENT_SOURCE_DIR})
    if(EXISTS ${_cyp_output_filename})
        include(cyp-inc.cmake)
    else()
        cyp_print("Failed to load cyp-inc.cmake!")
    endif()
endmacro(cyp_init)