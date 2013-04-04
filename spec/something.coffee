describe "BlackjackView.", ->

	beforeEach ->
		@blackjackView = new BlackjackView()
		@blackjackView

	describe "Initialize function:", ->

		it "should evaluate player's score to 0", ->
			expect(@blackjackView.playerScore).toEqual(0)

		it "should evaluate dealer's score to 0", ->
			expect(@blackjackView.dealerScore).toEqual(0)

		it "should create an empty player's hand", ->
			expect(@blackjackView.playerCards.length).toEqual(0)

		it "should create an empty dealer's hand", ->
			expect(@blackjackView.dealerCards.length).toEqual(0)

	describe "Reset function:", ->

		it "should add two cards to player's hand", ->
			@blackjackView.reset()
			expect(@blackjackView.playerCards.length).toEqual(2)

		it "should increase player's score by value of new cards", ->
			@blackjackView.reset()
			value1 = @blackjackView.playerCards.at(0).evaluate(0)
			value2 = @blackjackView.playerCards.at(1).evaluate(value1)
			expect(value1+value2).toEqual(@blackjackView.playerScore)

		it "should generate different cards", ->
			@blackjackView.reset()
			similarityCheck = (@blackjackView.playerCards.at(0).get('suit') == @blackjackView.playerCards.at(1).get('suit')) and (@blackjackView.playerCards.at(0).get('number') == @blackjackView.playerCards.at(1).get('number'))
			expect(similarityCheck).not.toBeTruthy()


	describe "Hit function:", ->

		it "should add one card to player's hand", ->
			@blackjackView.hit()
			expect(@blackjackView.playerCards.length).toEqual(1)

		it "should increase player's score by value of a new card", ->
			@blackjackView.hit()
			expect(@blackjackView.playerCards.at(0).evaluate(0)).toEqual(@blackjackView.playerScore)

	# describe "Stand function:", ->

describe "CardModel.", ->

	beforeEach ->
		@card = new Card()
		@card


	describe "Initialize function:", ->

		it "should create a property 'suit'", ->
			expect(@card.has('suit')).toBeTruthy()

		it "should evaluate 'suit' to an integer between 0 and 3", ->
			expect(typeof @card.get('suit')=='number' and @card.get('suit')%1 == 0 and 0 <= @card.get('suit') <= 3).toBeTruthy()

		it "should create a property 'number'", ->
			expect(@card.has('number')).toBeTruthy()

		it "should evaluate 'number' to an integer between 2 and 14", ->
			expect(typeof @card.get('number')=='number' and @card.get('number')%1 == 0 and 2 <= @card.get('number') <= 14).toBeTruthy()

	describe "Describe function:", ->

		it "should return a string", ->
			expect(typeof @card.describe()).toEqual('string')

		it "should return a string describing suit and number of the card", ->
			suits = ["spades", "hearts", "diamonds", "clubs"]
			numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
			expect([@card.describe().split(' of ')[0], @card.describe().split(' of ')[1]]).toEqual([''+numbers[@card.get('number')-2],suits[@card.get('suit')]])

	describe "Evaluate function:", ->

		it "should evaluate cards between 2 and 10 to their number", ->
			@card.set({'number':8})
			expect(@card.evaluate(Math.random()*21)).toEqual(8)

		it "should evaluate Jack, Queen and King to 10", ->
			@card.set({'number' : 12})
			expect(@card.evaluate(Math.random()*21)).toEqual(10)

		it "should evaluate Ace to 11 if player's score is less than 11", ->
			@card.set({'number' : 14})
			expect(@card.evaluate(8)).toEqual(11)

		it "should evaluate Ace to 11 if player's score is bigger than 12", ->
			@card.set({'number' : 14})
			expect(@card.evaluate(12)).toEqual(1)




		
		












