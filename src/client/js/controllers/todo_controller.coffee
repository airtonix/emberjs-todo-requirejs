define [
		'ember'
		'application'
	], (Ember, App) ->

		App.TodosController = Ember.ArrayController.extend
			actions:
				createTodo: ->
					title = @get 'newTitle'
					if !title.trim()
						return

					todo = @store.createRecord 'todo',
						title: title
						isCompleted: false

					@set 'newTitle', ''

					todo.save()
					false