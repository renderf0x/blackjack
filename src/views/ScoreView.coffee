class window.ScoreView extends Backbone.View
  className: 'score-container'

  template: _.template '
    <h1>Scoreboard</h1>
    <h2>Player: <%= playerScore %></h2>
    <h2>Dealer: <%= dealerScore %></h2>
    '

  initialize: ->
    @render()
    @model.on "change", =>
      render()

  render: ->
    #no detach here due to no listeners on scoreboard
    @$el.html @template @model.attributes #maybe needs .attributes
