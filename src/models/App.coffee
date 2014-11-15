# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'scoreBoard', new Score()

    @get('playerHand').on 'bust', => @handlePlayerBust()
    @get('playerHand').on 'stand', => @handlePlayerStand()

    @get('dealerHand').on 'bust', => @handleDealerBust()
    @get('dealerHand').on 'stand', => @handleDealerStand()

  handlePlayerBust: ->
    @endGame "dealer"

  handlePlayerStand: ->
    @playDealerHand()

  handleDealerBust: ->
    #alert "Dealer Bust!"
    @endGame "player"

  handleDealerStand: ->
    # Choose a winner
    console.log "Dealer Standing!"
    if @get('dealerHand').maxScore() > @get('playerHand').maxScore()
      @endGame("dealer")
    else if @get('dealerHand').maxScore() < @get('playerHand').maxScore()
      @endGame("player")
    else
      @endGame("push")

  playDealerHand: ->
    @get('dealerHand').at(0).flip()
    @get('dealerHand').hit() while @get('dealerHand').scores()[0] < 17 and (@get('dealerHand').scores()[1] < 17 or @get('dealerHand').scores()[1] > 21)
    if @get('dealerHand').scores()[0] < 22 and @get('dealerHand').scores()[1] then @get('dealerHand').stand()

  endGame: (winner) ->

    @trigger 'endGame', @

    if winner is "dealer"
      @get('scoreBoard').dealerIncr()
      console.log "dealer win (endGame)" #@trigger('lose', @)
    if winner is "player"
      @get('scoreBoard').playerIncr()
      console.log "player win (endGame)" #@trigger('won', @)
    if winner is "push"
      console.log "push it real good"

  resetGame: =>
    #TODO: make game reset REALLY work
    # @initialize()

    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

    @get('playerHand').on 'bust', => @handlePlayerBust()
    @get('playerHand').on 'stand', => @handlePlayerStand()

    @get('dealerHand').on 'bust', => @handleDealerBust()
    @get('dealerHand').on 'stand', => @handleDealerStand()

    @trigger "resetGame", @
