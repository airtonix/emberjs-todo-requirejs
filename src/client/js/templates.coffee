define [
	'lodash'
	'ember'
	'ehbs!app'
], (_,Ember) ->

	console.log "#{_.keys(Ember.TEMPLATES).length} templates loaded"