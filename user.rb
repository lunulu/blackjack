# frozen_string_literal: true

# User
class User < Player
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end

  private

  attr_writer :name
end
