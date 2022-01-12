# frozen_string_literal: true

# Deck
class Deck
  attr_reader :cards

  def initialize
    @cards = []
    add_suit_cards(:diamonds)
    add_suit_cards(:clubs)
    add_suit_cards(:hearts)
    add_suit_cards(:spades)
  end

  def shuffle
    cards.shuffle!
  end

  def pop
    cards.pop
  end

  private

  attr_writer :cards

  def add_suit_cards(suit)
    13.times { |i| @cards << Card.new(i + 1, suit) }
  end
end
