nodext = require 'nodext'
express = require 'express'
compile = require "compile-middleware"
fs = require 'fs'
path = require 'path'
sass = require "node-sass"
coffee = require "coffee-script"
jade = require 'jade'


class BaseAssetExtension extends nodext.Extension
    name: "Assets"

    configure: (server) ->
        server.use express.favicon()

module.exports = BaseAssetExtension