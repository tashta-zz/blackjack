
class window.BlackjackView extends Backbone.View

  events:
    "click .hit-button": "hit"
    "click .stand-button": "stand"
    "click .reset-button": "reset"


  initialize: ->
    @playerScore = 0
    @dealerScore = 0
    @playerCards = new Cards()
    @dealerCards = new Cards()
    @$('.dealer-cards').html('')
    @$('.player-cards').html('')
    @$('.player-score').text(0)
    @$('.dealer-score').text(0)
    @$('.hit-button').hide()
    @$('.stand-button').hide()


  reset: ->
    @initialize()
    for num in [0..1]
      @hit()
    @$('.hit-button').show()
    @$('.stand-button').show()


  hit: ->
    newCard = new Card()
    if @noRepeats(@playerCards.models, newCard)
      @playerCards.add(newCard)
      @$('.player-cards').append(newCard.describe() + '<br>')
      @playerScore += newCard.evaluate(@playerScore)
      @$('.player-score').text(@playerScore)
      @check()
    else
      @hit()


  noRepeats: (models, newCard)->
    _.every(models, (val)->
      !(val.describe() == newCard.describe())
      )


  stand: ->
    while @dealerScore < 17
      newCard = new Card()
      if (@noRepeats(@playerCards.models, newCard) and @noRepeats(@dealerCards.models, newCard))
        @dealerCards.add(newCard)
        @$('.dealer-cards').append(newCard.describe() + '<br>')
        @dealerScore += newCard.evaluate(@dealerScore)
        @$('.dealer-score').text(@dealerScore)
    @compare()


  check: ->
    if @playerScore > 21
      alert "You lost!"
      @initialize()
    if @playerScore == 21
      alert "You won!"
      @initialize()


  compare: ->
    if @dealerScore > 21 or @playerScore > @dealerScore
      alert "You won!"
    else if @playerScore == @dealerScore
      alert "A draw!"
    else
      alert "You lost!"
    @initialize()


