class window.Score extends Backbone.Model
  initialize: ->
    @set 'playerScore', 0
    @set 'dealerScore', 0
    @set 'lastWinnerMsg', 'none'

  playerIncr: ->
    @set 'playerScore', @get('playerScore') + 1
    @set 'lastWinnerMsg', 'You Win!'

  dealerIncr: ->
    @set 'dealerScore', @get('dealerScore') + 1
    @set 'lastWinnerMsg', 'Dealer Wins!'

  pushGame: ->
    @set 'lastWinnerMsg', 'Push!'
