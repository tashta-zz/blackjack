// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.BlackjackView = (function(_super) {

    __extends(BlackjackView, _super);

    function BlackjackView() {
      return BlackjackView.__super__.constructor.apply(this, arguments);
    }

    BlackjackView.prototype.events = {
      "click .hit-button": "hit",
      "click .stand-button": "stand",
      "click .reset-button": "reset"
    };

    BlackjackView.prototype.initialize = function() {
      this.playerScore = 0;
      this.dealerScore = 0;
      this.playerCards = new Cards();
      this.dealerCards = new Cards();
      this.$('.dealer-cards').html('');
      this.$('.player-cards').html('');
      this.$('.player-score').text(0);
      this.$('.dealer-score').text(0);
      this.$('.hit-button').hide();
      return this.$('.stand-button').hide();
    };

    BlackjackView.prototype.reset = function() {
      var num, _i;
      this.initialize();
      for (num = _i = 0; _i <= 1; num = ++_i) {
        this.hit();
      }
      this.$('.hit-button').show();
      return this.$('.stand-button').show();
    };

    BlackjackView.prototype.hit = function() {
      var newCard;
      newCard = new Card();
      if (this.noRepeats(this.playerCards.models, newCard)) {
        this.playerCards.add(newCard);
        this.$('.player-cards').append(newCard.describe() + '<br>');
        this.playerScore += newCard.evaluate(this.playerScore);
        this.$('.player-score').text(this.playerScore);
        return this.check();
      } else {
        return this.hit();
      }
    };

    BlackjackView.prototype.noRepeats = function(models, newCard) {
      return _.every(models, function(val) {
        return !(val.describe() === newCard.describe());
      });
    };

    BlackjackView.prototype.stand = function() {
      var newCard;
      while (this.dealerScore < 17) {
        newCard = new Card();
        if (this.noRepeats(this.playerCards.models, newCard) && this.noRepeats(this.dealerCards.models, newCard)) {
          this.dealerCards.add(newCard);
          this.$('.dealer-cards').append(newCard.describe() + '<br>');
          this.dealerScore += newCard.evaluate(this.dealerScore);
          this.$('.dealer-score').text(this.dealerScore);
        }
      }
      return this.compare();
    };

    BlackjackView.prototype.check = function() {
      if (this.playerScore > 21) {
        alert("You lost!");
        this.initialize();
      }
      if (this.playerScore === 21) {
        alert("You won!");
        return this.initialize();
      }
    };

    BlackjackView.prototype.compare = function() {
      if (this.dealerScore > 21 || this.playerScore > this.dealerScore) {
        alert("You won!");
      } else if (this.playerScore === this.dealerScore) {
        alert("A draw!");
      } else {
        alert("You lost!");
      }
      return this.initialize();
    };

    return BlackjackView;

  })(Backbone.View);

}).call(this);