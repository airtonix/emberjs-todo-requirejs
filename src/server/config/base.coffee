path = require 'path'

module.exports =
	projectRoot: path.resolve __dirname, '..'
	server:
		hostname: "127.0.0.1"
		port: 8000,
		view: 
			options: 
				root: "./views"

	extensions:
		"/":
			name: "home"
			location: "./features/home"

		"/static/":
			name: "assets"
			location: "./features/assets" 

		