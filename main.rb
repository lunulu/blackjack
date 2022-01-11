# frozen_string_literal: true

require 'io/console'
require 'colorize'
require_relative 'blackjack'

# App
class App
  attr_reader :blackjack

  def start
    welcome_message

    print 'Введите имя: '
    name = gets.chomp
    @blackjack = Blackjack.new(name)
    blackjack.start_game
    loop do
      unless blackjack.valid_deposits?
        puts 'У одного из игроков закончились деньги'
        break
      end

      puts "Ваш баланс: #{blackjack.user.deposit}. Баланс дилера: #{blackjack.dealer.deposit}. Банк: 20"
      print "#{blackjack.user.name}, ваши карты: "
      visualise_cards(blackjack.user)

      choose_option_message
      case $stdin.getch
      when '1' then blackjack.controller(:skip_turn)
      when '2' then show_cards
      when '3' then blackjack.controller(:add_card)
      when '0' then break
      else puts 'Такого пункта нет'
      end
    end

    puts 'Хотите сыграть еще раз?'
    puts '1 - Да, любая другая клавиша - Нет'
    $stdin.getch == '1' ? start : return
  end

  def welcome_message
    system 'clear'
    puts 'Игра "Блэкджек"'
    sleep 1.5
  end

  def show_cards
    show_cards_message
    case blackjack.controller(:show_cards)
    when 1 then puts 'Вы победили'.green
    when 0 then puts 'Ничья'.yellow
    when -1 then puts 'Вы проиграли'.red
    end
    waiting
    blackjack.start_game
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

  def show_cards_message
    print 'Ваши карты: '
    visualise_cards(blackjack.user)
    puts "Ваш счет: #{blackjack.user.score}"
    print 'Карты дилера: '
    visualise_cards(blackjack.dealer)
    puts "Счет дилера: #{blackjack.dealer.score}"
  end

  def choose_option_message
    puts '1 - Пропустить ход'
    puts '2 - Открыть карты'
    puts '3 - Добавить карту' if blackjack.user.cards.size < 3
    puts '0 - Выйти'
  end

  def waiting
    puts 'Нажмите любую клавишу чтобы продолжить'
    $stdin.getch
    system 'clear'
  end
end

app = App.new
app.start
