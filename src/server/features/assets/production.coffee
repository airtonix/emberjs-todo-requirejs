BaseAssetExtension	= require './base'
express 			= require 'express'
path				= require 'path'


class ProductionAssets extends BaseAssetExtension
    name: "Assets"
    config:
        assetsRoot: path.resolve __dirname, "../../../../build"

    configure: (server) ->
        server.use "/", express.static @config.assetsRoot
        super server

exports.extension = ProductionAssets