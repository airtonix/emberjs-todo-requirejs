define [
		'lodash'
		'ember'
		'ember-data'
		'../app'
		'./fixtures'
		'./routes'
		'./models'
	], (_, Ember, EmberData,
		App, Fixtures, Routes, Models) ->

		for key, model in Models
			App[key] = model

		for key, data in Fixtures
			if _.has App, key
				App[key].FIXTURES = Fixtures

		for key, route in Routes
			console.log key, route
			App["#{key}Route"] = route

		@