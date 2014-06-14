define [
	'ember'
	'ember-data'
	'application'
	], (Ember, EmberData, App) ->

		App.Todo = DS.Model.extend
			title: DS.attr 'string'
			isCompleted: DS.attr 'boolean'
