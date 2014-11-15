class window.AppView extends Backbone.View
  template: _.template '
    <div class="container">
      <button class="hit-button btn btn-success">Hit</button> <button class="stand-button btn btn-warning">Stand</button>
      <div class="row">
        <div class="col-md-6">
          <div class="player-hand-container"></div>
        </div>
        <div class="col-md-4">
          <div class="score-container"></div>
        </div>
        <div class="col-md-2">
          <img class="windoze" src="img/windoze.jpg">
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="dealer-hand-container"></div>
        </div>
        <div class="resetSection col-md-4">
          <button class="btn btn-lg btn-default play-again-button disabled">Play Again!</button>
        </div>
      </div>
    </div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-again-button': -> @model.resetGame()

  initialize: ->
    @render()
    @model.on "resetGame", =>
      @render()
    @model.on "endGame", =>
      @disableGameButtons()

  disableGameButtons: ->
    #stuff
    $('.hit-button').toggleClass "disabled"
    $('.stand-button').toggleClass "disabled"
    $('.play-again-button').toggleClass "disabled" #this starts disabled on every render

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.score-container').html new ScoreView(model: @model.get 'scoreBoard').el

