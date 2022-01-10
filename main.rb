# frozen_string_literal: true

require 'io/console'
require 'colorize'
require_relative 'blackjack'

def console_game
  welcome_message

  print 'Введите имя: '
  name = gets.chomp
  blackjack = Blackjack.new(name)
  blackjack.start_game
  loop do
    unless blackjack.valid_deposits?
      puts 'У одного из игроков закончились деньги'
      break
    end

    print 'Ваши карты: '
    visualise_cards(blackjack.user)

    puts '1 - Пропустить ход'
    puts '2 - Открыть карты'
    puts '3 - Добавить карту' if blackjack.user.cards.size < 3
    puts '0 - Выйти'

    case $stdin.getch
    when '1' then blackjack.controller(:skip_turn)
    when '2'
      puts "Ваш баланс: #{blackjack.user.deposit}. Баланс дилера: #{blackjack.dealer.deposit}"
      print 'Ваши карты: '
      visualise_cards(blackjack.user)
      print 'Карты дилера: '
      visualise_cards(blackjack.dealer)
      case blackjack.controller(:show_cards)
      when 1
        puts 'Вы победили'
        2.times { blackjack.user.increase_deposit }
        blackjack.controller(:new_deal)
      when 0
        puts 'Ничья'
        blackjack.user.increase_deposit
        blackjack.dealer.increase_deposit
        blackjack.controller(:new_deal)
      when -1
        puts 'Вы проиграли'
        2.times { blackjack.dealer.increase_deposit }
        blackjack.controller(:new_deal)
      end
      sleep 5
      system 'clear'
      blackjack.start_game
    when '3' then blackjack.controller(:add_card)
    when '0' then break
    else puts 'Такого пункта нет'
    end
  end

  puts 'Хотите сыграть еще раз?'
  puts '1 - Да, любая другая клавиша - Нет'
  $stdin.getch == '1' ? console_game : return
end

def welcome_message
  system 'clear'
  puts 'Игра "Блэкджек"'
  sleep 1.5
end

def visualise_cards(player)
  unicode_hash = { diamonds: "\u2666", clubs: "\u2663", hearts: "\u2665", spades: "\u2660" }
  colors = { diamonds: :red, clubs: :black, hearts: :red, spades: :black }
  player.cards.each do |card|
    print " #{card.name}#{unicode_hash[card.suit]} ".colorize(color: colors[card.suit], background: :white)
    print ' '
  end
  puts
end

console_game
