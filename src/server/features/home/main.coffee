nodext 			= require 'nodext'
controllers 	= require './controllers'

class HomeFeature extends nodext.Extension
	name: 'Home'
	
	registerRoutes: (server) ->
		controllers server

exports.extension = HomeFeature