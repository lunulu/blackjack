# frozen_string_literal: true

# Hand
class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def score
    @score = cards.map(&:value).sum
    @score += 10 if cards.map(&:name).include?('A') && @score + 10 <= 21
    @score
  end
end
