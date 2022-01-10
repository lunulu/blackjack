# frozen_string_literal: true

# Card
class Card
  attr_reader :name, :value, :suit

  def initialize
    random = rand(1..12)
    random = 10 if random > 10
    @value = random
    @name = case value
            when 1 then 'A'
            when 10 then %w[K Q J].sample
            else value.to_s
            end
    @suit = %i[diamonds clubs hearts spades].sample
  end

  private

  attr_writer :name, :value, :suit
end
