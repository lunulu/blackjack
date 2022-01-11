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
    when :add_card
      user.add_card
      dealer_turn
    when :show_cards then show_cards
    when :skip_turn then dealer_turn
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
    if (user.score > 21 && dealer.score > 21) || user.score == dealer.score
      user.increase_deposit
      dealer.increase_deposit
      0
    elsif user.score > 21 || dealer.score > user.score
      2.times { dealer.increase_deposit }
      -1
    else
      2.times { user.increase_deposit }
      1
    end
  end

  def dealer_turn
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
