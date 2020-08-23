#!/usr/bin/python3

import sys
import os
import yaml

class CYPLoader(yaml.SafeLoader):

    def __init__(self, stream):
        self._root = os.path.split(stream.name)[0]
        super(CYPLoader, self).__init__(stream)

    def include(self, node):
        filename = os.path.join(self._root, self.construct_scalar(node))
        with open(filename, 'r') as file_handler:
            return yaml.load(file_handler, Loader=CYPLoader)

CYPLoader.add_constructor('!include', CYPLoader.include)


class YamlParser(object):
    CYP_VERSION="0.1.1"
    OUTPUT_FILE_TYPE_CMAKE="cmake file"
    def __init__(self, yaml_filename):
        try:
            with open(yaml_filename, 'r') as file_handler:
                self._yaml = yaml.load(stream=file_handler, Loader=CYPLoader)
        except FileNotFoundError:
            print("error: no such a file: {}".format(yaml_filename))
            raise
        print(self._yaml)

    def output_file(self, file_type, filename):
        if file_type == self.OUTPUT_FILE_TYPE_CMAKE:
            self._output_cmake_file(filename=filename)

    def _output_cmake_file(self, filename):
        with open(filename, 'w') as file_handler:
            file_handler.write("set(CYP_VERSION \"{}\")".format(self.CYP_VERSION))
        print("write file {}".format(filename))

if "__main__" == __name__:
    # input param
    yaml_filename = sys.argv[1]
    output_filename = sys.argv[2]

    # write file
    yaml_parser = YamlParser(yaml_filename)
    yaml_parser.output_file(file_type=YamlParser.OUTPUT_FILE_TYPE_CMAKE, filename=output_filename)
