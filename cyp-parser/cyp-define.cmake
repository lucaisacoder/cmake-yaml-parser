set(_cyp_doc_separate "---")
set(_cyp_doc_separate_without_a_new_doc "...")


set(_cyp_sequence_entry "-")
set(_cyp_mapping_key    "?")
set(_cyp_mapping_value  ":")
set(_cyp_collect_entry  ",")
set(_cyp_sequence_start "[")
set(_cyp_sequence_end   "]")
set(_cyp_mapping_start  "{")
set(_cyp_mapping_end    "}")
set(_cyp_comment        "#")
set(_cyp_anchor         "&")
set(_cyp_alias          "*")
set(_cyp_tag            "!")
set(_cyp_literal        "|")
set(_cyp_folded         ">")
set(_cyp_single_quote   "\'")
set(_cyp_double_quote   "\"")
set(_cyp_directive      "%")
set(_cyp_reserved       "@" "`")


set(_cyp_indicator      ${_cyp_sequence_entry}
                        ${_cyp_mapping_key}
                        ${_cyp_mapping_value}
                        ${_cyp_collect_entry}
                        ${_cyp_sequence_start}
                        ${_cyp_sequence_end}
                        ${_cyp_mapping_start}
                        ${_cyp_mapping_end}
                        ${_cyp_comment}
                        ${_cyp_anchor}
                        ${_cyp_alias}
                        ${_cyp_tag}
                        ${_cyp_literal}
                        ${_cyp_folded}
                        ${_cyp_single_quote}
                        ${_cyp_double_quote}
                        ${_cyp_directive}
                        ${_cyp_reserved}
)

set(_cyp_flow_indicator ${_cyp_collect_entry}
                        ${_cyp_sequence_start}
                        ${_cyp_sequence_end}
                        ${_cyp_mapping_start}
                        ${_cyp_mapping_end}
)

set(_cyp_s_space        " ")

# * n
set(_cyp_indent_level0 "")
set(_cyp_indent_level1 "${_cyp_s_space}")
set(_cyp_indent_level2 "${_cyp_s_space} ${_cyp_indent_level1}")
set(_cyp_indent_level3 "${_cyp_s_space} ${_cyp_indent_level2}")
set(_cyp_indent_level4 "${_cyp_s_space} ${_cyp_indent_level3}")
set(_cyp_indent_level5 "${_cyp_s_space} ${_cyp_indent_level4}")


set(_cyp_s_separate_in_line     " ") # * n


set(_cyp_primary_tag            "!")
set(_cyp_second_tag             "!!")


set(_cyp_e_scalar               "")
set(_cyp_e_conver               "\\")