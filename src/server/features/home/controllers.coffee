_ = require 'lodash'
locals = {}

module.exports = (server) ->

	server.get "/", (req, res) ->
		res.render 'home.jade'
