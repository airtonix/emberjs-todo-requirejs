define [
		'ember'
		'ember-data'
	], (Ember, EmberData) ->

		Todos: Ember.Route.extend
			model: () ->
				@store.find 'todo'

