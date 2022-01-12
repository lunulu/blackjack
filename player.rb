# frozen_string_literal: true

# Player
class Player
  INITIAL_DEPOSIT = 100

  attr_reader :deposit, :cards

  @@deck = Deck.new.shuffle

  def initialize
    @deposit = INITIAL_DEPOSIT
    @cards = []
  end

  def score
    @score = cards.map(&:value).sum
    @score += 10 if cards.map(&:name).include?('A') && @score + 10 <= 21
    @score
  end

  def add_card
    cards << @@deck.pop if cards.size < 3
  end

  def delete_cards
    self.cards = []
  end

  def increase_deposit
    self.deposit += 10
  end

  def decrease_deposit
    self.deposit -= 10
  end

  private

  attr_writer :cards, :deposit, :score
end
