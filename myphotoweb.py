import sys
import argparse
import pyjade
from pyjade.ext.html import HTMLCompiler
import lesscpy
import os

class Compiler(HTMLCompiler):
    def visitInclude(self, node):
        if os.path.exists(node.path):
            src = open(node.path, 'r').read()
        elif os.path.exists("%s.jade" % node.path):
            src = open("%s.jade" % node.path, 'r').read()
        else:
            raise Exception("Include path doesn't exists")

        parser = pyjade.parser.Parser(src)
        block = parser.parse()
        self.visit(block)

# create the top-level parser
parser = argparse.ArgumentParser(prog='myphotoweb')

subparsers = parser.add_subparsers(help='build')

subparsers.add_parser('init', help='init directory for myphotoweb')
subparsers.add_parser('init-template', help='create a new template')
subparsers.add_parser('add-page', help='add-page')
parser_build = subparsers.add_parser('build', help='build')
parser_build.add_argument("build", action='store_true')

if __name__ == '__main__':
    args = parser.parse_args()
    if 'build' in args and args.build:
        for page in os.listdir("pages"):
            path = "pages/{}".format(page)
            content = open(path, 'r').read()
            result = pyjade.process(content, compiler=Compiler)
            print(result)
