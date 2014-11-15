class window.CardView extends Backbone.View
  className: 'card'

  #template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'
  coveredTemplate: _.template '<img src="img/card-back.png">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    #@$el.addClass 'covered' unless @model.get 'revealed'
    @$el.html @coveredTemplate unless @model.get 'revealed'

