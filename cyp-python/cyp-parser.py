#!/usr/bin/python3

import sys

PARSER_VERSION = "0.1.0"
if "__main__" == __name__:
    print("hello world;%s" % (sys.argv))
    filename = sys.argv[2]
    with open(filename, 'w') as file_handler:
        file_handler.write("set(PARSER_VERSION \"{}\")".format(PARSER_VERSION))
    print("write file {}".format(filename))