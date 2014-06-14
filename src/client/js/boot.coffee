require.config
	urlArgs: "bust=" +  (new Date()).getTime()

	# Setup shortnames for these paths
	# we use them later on through out the project
	# to ensure these libraries are loaded before
	# a particular module is executed.
	paths:
		'lodash': 		'../vendor/lodash/dist/lodash'
		'lodash-math': 	'../vendor/lodash-math/lodash.math'
		'moment': 		'../vendor/momentjs/moment'
		'jquery': 		'../vendor/jquery/dist/jquery'
		'ember': 		'../vendor/ember/ember'
		'ember-data': 	'../vendor/ember-data/ember-data'
		'handlebars': 	'../vendor/handlebars/handlebars'
		'ehbs':			'../vendor/requirejs-ember-handlebars/ehbs'
		'text':			'../vendor/requirejs-text/text'
		'application':	'./application'

	# some non-AMD libs need other libs loaded first so we manually define them here
	shim :
		'lodash': exports: '_'
		'lodash-math': deps: ['lodash']
		'handlebars': exports: 'Handlebars'
		'ehbs': deps: ['text', 'handlebars']
		'ember-data': deps: ['ember']
		'ember':
			exports: 'Ember' 
			deps: [
				'jquery'
				'handlebars'
			]
		'application':
			deps: [
				'ember'
				'ember-data'
			]
	ehbs:
		extension: 'tpl.html'
		ember: 'ember'

	deps: ['main']
