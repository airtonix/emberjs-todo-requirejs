#!/usr/bin/env coffee
server = require "nodext/lib/server"
config = require "./config"
app = server.createApplication config

if !module.parent
	app.listen config.server.port, ->
		console.log "Server listening in #{config.server.hostname}:#{config.server.port}"
else
	module.exports = app