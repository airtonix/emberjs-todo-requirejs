define [
	'lodash'
	'application'
	'./store'
	'./templates'
	'./models/todo'
	], (_, App) ->

		App.Router.map () ->
			@resource 'app', path: '/'