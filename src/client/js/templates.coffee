define [
	'lodash'
	'ember'
	'ehbs!todos'
], (_,Ember) ->

	console.log "#{_.keys(Ember.TEMPLATES).length} templates loaded"