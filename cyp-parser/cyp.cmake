include(cyp-parser)

macro(cyp_load filename)
    file(READ ${filename} _file_content)
    # message(">>>> _file_content=${_file_content}")
    cyp_init()
    cyp_parser(${_file_content})
endmacro()