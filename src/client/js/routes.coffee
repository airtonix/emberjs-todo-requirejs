define [
		'ember'
		'application'
	], (Ember, App) ->

		App.Router.map () ->
			@resource 'todos', path: '/'

		App.TodosRoute = Ember.Route.extend
			model: () ->
				@store.find 'todo'