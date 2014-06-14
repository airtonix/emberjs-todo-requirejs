define [
		'ember'
		'ember-data'
	], (Ember, EmberData) ->

		Todo: DS.Model.extend
			title: DS.attr 'string'
			isCompleted: DS.attr 'boolean'
