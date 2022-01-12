# frozen_string_literal: true

# Card
class Card
  attr_reader :name, :value, :suit

  def initialize(value, suit)
    @value = value
    @name = case value
            when 1 then 'A'
            when 11 then 'J'
            when 12 then 'Q'
            when 13 then 'K'
            else value.to_s
            end
    @value = 10 if value > 10
    @suit = suit
  end

  private

  attr_writer :name, :value, :suit
end
