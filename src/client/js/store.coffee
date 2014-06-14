define [
	'ember'
	'ember-data'
	'application'
], (Ember, EmberData, App) ->

	App.Store = DS.Store.extend
		revision: 1
		adapter: DS.FixtureAdapter