define [
	'ember'
	'ember-data'
	], (Ember) ->

		Ember.Application.create
			VERSION: '1.0'
			rootElement: 'section[data-ember-application]'
			LOG_TRANSITIONS: true # basic logging of successful transitions
			LOG_TRANSITIONS_INTERNAL: true # detailed logging of all routing steps

			ready: () ->
				@set 'Router.enableLogging', true
