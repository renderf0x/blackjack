class window.Score extends Backbone.Model
  initialize: ->
    @set 'playerScore', 0
    @set 'dealerScore', 0

  playerIncr: ->
    @set 'playerScore', @get('playerScore') + 1

  dealerIncr: ->
    @set 'dealerScore', @get('dealerScore') + 1
