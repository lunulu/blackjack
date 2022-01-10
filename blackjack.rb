# frozen_string_literal: true

require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'user'

# Blackjack
class Blackjack
  attr_reader :user, :dealer

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
  end

  def controller(input)
    case input
    when :add_card then user.add_card
    when :show_cards then show_cards
    when :skip_turn then skip_turn
    end
  end

  def start_game
    valid_deposits? ? new_deal : 10
  end

  def new_deal
    prepare_player(user)
    prepare_player(dealer)
  end

  def show_cards
    if user.score > dealer.score && user.score <= 21
      1
    elsif user.score == dealer.score
      0
    elsif user.score < dealer.score && dealer.score <= 21
      -1
    elsif user.score > 21 && dealer.score <= 21
      -1
    else
      1
    end
  end

  def skip_turn
    dealer.add_card if dealer.score < 17
  end

  def valid_deposits?
    user.deposit >= 10 && dealer.deposit >= 10 ? true : false
  end

  private

  attr_writer :user, :dealer

  def prepare_player(player)
    player.decrease_deposit
    player.delete_cards
    2.times { player.add_card }
  end
end
