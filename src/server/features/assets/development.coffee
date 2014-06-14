BaseAssetExtension  = require './base'
express             = require 'express'
compile             = require "compile-middleware"
fs                  = require 'fs'
path                = require 'path'
sass                = require "node-sass"
coffee              = require "coffee-script"
jade                = require 'jade'


class DevelopmentAssets extends BaseAssetExtension
    name: "Assets"
    config:
        vendorRoot: path.resolve __dirname, "../../../../bower_components"
        assetsRoot: path.resolve __dirname, "../../../client"

    configure: (server) ->
        sassOptions =
            include_paths: [
                path.join @config.vendorRoot, "bourbon", "app", "assets", "stylesheets"
                # path.join @config.vendorRoot, "ratchet", "sass"
                @config.assetsRoot
            ]

        assetMiddleware =
            js: compile
                src : @config.assetsRoot
                src_ext : '.coffee'
                headers :
                    'content-type': 'application/javascript'
                filename : (request) ->
                    request.path.replace ".js", ""
                render : (file, cb, deps) ->
                    fs.readFile file, 'utf8', (err, content) ->
                        if not err
                            cb null, coffee.compile(content)
                        cb err

            css: compile
                src : @config.assetsRoot
                src_ext : '.scss'
                headers :
                    'content-type': 'text/css'
                filename : (request) ->
                    request.path.replace ".css", ""
                render : (file, cb, deps) ->
                    fs.readFile file, 'utf8', (err, content) ->
                        if not err
                            cb null, sass.renderSync(content, sassOptions)
                        cb err

            html: compile
                src : @config.assetsRoot
                src_ext : '.jade'
                headers :
                    'content-type': "text/html"
                filename : (request) ->
                    request.path.replace ".html", ""
                render : (file, cb, deps) ->
                    fs.readFile file, 'utf8', (err, content) ->
                        if not err
                            cb null, jade.compile(content, {})()
                        cb err

        server.use express.logger 'dev'

        server.use "/", express.static @config.assetsRoot
        server.use "/vendor", express.static @config.vendorRoot

        server.use assetMiddleware.js
        server.use assetMiddleware.css
        server.use assetMiddleware.html

        super server

exports.extension = DevelopmentAssets