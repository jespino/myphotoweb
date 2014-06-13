#!/usr/bin/env coffee
#
ArgumentParser = require('argparse').ArgumentParser

parser = new ArgumentParser({
  version: '0.0.1'
  addHelp: true
  description: 'myphotoweb'
})

subparsers = parser.addSubparsers({
  title:'buildX'
  dest:"buildX"
})
parserBuild = subparsers.addParser('build')
parserBuild.addArgument(["build"], {action: 'storeTrue'})

subparsers.addParser('init')
subparsers.addParser('init-template')
subparsers.addParser('add-page')

args = parser.parseArgs()
console.dir(args)
if args.build
    console.log "HOLA"
