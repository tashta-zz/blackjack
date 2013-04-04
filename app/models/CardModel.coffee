suits = ["spades", "hearts", "diamonds", "clubs"]
numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]

class window.Card extends Backbone.Model
	
  initialize: ->
    @set
      number: 2 + Math.floor Math.random() * 13
      suit: Math.floor Math.random() * 4

  describe: ->
    numbers[@get('number')-2] + ' of ' + suits[@get('suit')]

  evaluate: (score)->
    if 9 < @get('number') < 14
      10
    else if @get('number') == 14
      if score>10 
        1 
      else 
        11
    else
      @get('number')

