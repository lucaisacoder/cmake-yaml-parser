#!/usr/bin/python3

import unittest
import sys
import os

sys.path.append(os.path.join(os.path.dirname(__file__), os.pardir))
from cyp_python.cyp_parser import YamlParser

class TestYamlParser(unittest.TestCase):

    def setUp(self):
        # input param
        yaml_filename = os.path.join(os.getcwd(), "test.yaml")
        output_filename = os.path.join(os.getcwd(), "test.cmake")

        # write file
        self.yaml_parser = YamlParser(yaml_filename)
        self.yaml_parser.output_file(file_type=YamlParser.OUTPUT_FILE_TYPE_CMAKE, filename=output_filename)

    def test_content(self):
        print(self.yaml_parser)


if __name__ == '__main__':
    unittest.main()
