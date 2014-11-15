class window.ScoreView extends Backbone.View
  className: 'score-container'

  template: _.template '
    <h1>Scoreboard</h1>
    <h2>Player: <%= playerScore %></h2>
    <h2>Dealer: <%= dealerScore %></h2>
    '
  modalTemp: _.template '
    <div class="modal fade" id="modal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">Round Over</h4>
          </div>
          <div class="modal-body">
            <p class="winnerMsg"><%= lastWinnerMsg %></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Awesome!</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->'

  gameModal: ->
    $('#modal').modal()

  initialize: ->
    @render()
    @model.on "change", =>
      @render()
      @gameModal()

  render: ->
    #no detach here due to no listeners on scoreboard
    @$el.html @template @model.attributes #maybe needs .attributes
    @$el.append @modalTemp @model.attributes
