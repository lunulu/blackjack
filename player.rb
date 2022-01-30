# frozen_string_literal: true

# Player
class Player
  INITIAL_DEPOSIT = 100

  attr_reader :deposit, :hand

  # rubocop:disable Style/ClassVars
  @@deck = Deck.new(8).shuffle

  def initialize
    @deposit = INITIAL_DEPOSIT
    @hand = Hand.new
  end

  def score
    hand.score
  end

  def cards
    hand.cards
  end

  def add_card
    cards << @@deck.pop if cards.size < 3
  end
  # rubocop:enable Style/ClassVars

  def clear_hand
    hand.cards = []
  end

  def increase_deposit
    self.deposit += 10
  end

  def decrease_deposit
    self.deposit -= 10
  end

  private

  attr_writer :deposit, :hand
end
