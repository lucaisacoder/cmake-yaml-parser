include(cyp-define)

macro(cyp_init)
    set(global_index 0)
    set(global_yaml_string "")
    set(global_yaml_string_length 0)
    set(global_char "")
    set(global_word "")
    set(global_keyword "")
endmacro(cyp_init)

# macro(cyp_parser_block _yaml_string _block_string)
#     # message("cyp_parser_block ${_yaml_string}")
#     set(_block_string "aaaaa")
#     math(EXPR global_index "${global_index} + 10")
# endmacro(cyp_parser_block)

macro(cyp_print _string)
    message("[DEBUG] ${_string}")
endmacro(cyp_print)

macro(cyp_goto_next_char)
    math(EXPR global_index "${global_index} + 1")
endmacro(cyp_goto_next_char)

macro(cyp_get_char)
    string(SUBSTRING "${global_yaml_string}" ${global_index} 1 global_char)
    cyp_goto_next_char()
endmacro(cyp_get_char)

macro(cyp_goto_next_word)
    while(${global_index} LESS ${global_yaml_string_length})
        string(SUBSTRING "${global_yaml_string}" ${global_index} 1 _char)
        if(NOT ${_char} IN_LIST _cyp_indicator)
            break()
        endif()
        cyp_goto_next_char()
    endwhile()
endmacro(cyp_goto_next_word)

macro(cyp_get_word)
    while(${global_index} LESS ${global_yaml_string_length})
        string(SUBSTRING "${global_yaml_string}" ${global_index} 1 _char)
        if(NOT ${_char} IN_LIST _cyp_none_word_char)
            string(APPEND global_word ${_char})
        else()
            break()
        endif()
        cyp_goto_next_char()
    endwhile()
endmacro(cyp_get_word)

macro(cyp_parser _yaml_string)
    set(global_yaml_string "${_yaml_string}")
    unset(_yaml_string)
    string(LENGTH ${global_yaml_string} global_yaml_string_length)
    while(${global_index} LESS ${global_yaml_string_length})
        # string(SUBSTRING "${global_yaml_string}" ${global_index} 1 _char)
        cyp_goto_next_word()
        cyp_get_char()
        cyp_goto_next_word()
        #cyp_get_char()
        #cyp_get_char()

        # cyp_print(${global_keyword})
        cyp_print(${global_word})
        cyp_print(${global_char})
        break()
    endwhile()
endmacro(cyp_parser)