class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @bust() if @scores()[0] > 21 and @scores()[1] > 21

  stand: ->
    @trigger 'stand', @

  bust: ->
    @trigger 'bust', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  maxScore: ->
    # if scores != to each other. return the largest score that is 21 or under
    if @scores()[0] != @scores()[1] and @scores()[1] <= 21
      @scores()[1]
    else
      @scores()[0]

    # else return score[0]
    ##old logic
    #Math.max @scores()[0], @scores()[1]

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


