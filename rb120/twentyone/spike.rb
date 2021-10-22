# frozen_string_literal: true

# Card object
class Card
  ACE = 'A'
  FACE_VALUE = 10
  ACE_VALUE = 1

  attr_reader :face, :suit, :value

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = card_value
  end

  def ace?
    face == ACE
  end

  def to_s
    "[#{face}#{suit}]"
  end

  def self.hidden
    "[??]"
  end

  private

  def card_value
    return(face) unless Deck::FACES.include? face

    face == ACE ? ACE_VALUE : FACE_VALUE
  end
end

# Tracks the remaining cards in a deck
class Deck
  NUMBERS = (2..10).to_a
  FACES = %w(J Q K A)
  SUITS = %w(♥ ♠ ♦ ♣)

  def initialize
    @cards = []
    shuffle
  end

  def deal_card
    shuffle if cards.empty?
    cards.pop
  end

  private

  def shuffle
    card_array = (NUMBERS + FACES).product(SUITS)
    self.cards += card_array.map { |attributes| Card.new(*attributes) }.shuffle
  end

  attr_accessor :cards
end

# Tracks player hands
class Participant
  BUST = 21

  attr_reader :name

  def initialize
    @name = choose_name
  end

  def discard_hand
    @hand = []
  end

  def draw_card(deck)
    @hand << deck.deal_card
  end

  def show_hand(hide_cards: false)
    first_card = hide_cards ? Card.new('?', '?') : @hand.first
    cards = @hand[1..-1].map(&:to_s).join
    total = hide_cards ? '' : " = #{hand_total}"
    status = busted? ? ' *busted*' : ''

    puts "#{@name}: #{first_card}#{cards}#{total}#{status}"
  end

  def busted?
    hand_total > BUST
  end

  def <=>(other)
    hand_total <=> other.hand_total
  end

  protected

  def hand_total
    total = @hand.sum(&:value)
    total_max_ace = total + Card::FACE_VALUE
    total = total_max_ace if @hand.any?(&:ace?) && (total_max_ace <= BUST)

    total
  end
end

class Dealer < Participant
  STAY_ON = 17

  def choose_name; 'Dealer'; end

  def stay?
    hand_total >= STAY_ON || busted?
  end
end

class Player < Participant
  def choose_name; 'Player'; end

  def prompt
    choice = nil
    loop do
      puts "Hit or Stay (h/s)?"
      choice = gets.chomp
      break if %w(h s).include? choice

      puts 'Incorrect selection. Choose hit or stay (h/s)...'
    end
    choice
  end

  def continue?
    choice = nil
    loop do
      print 'Play again (y/n)?'
      choice = gets.chomp
      break if %w(y n).include? choice

      puts 'Invalid selection...'
    end
    choice == 'y'
  end
end

# Contains the game logic particular to the Twenty-One game
class Game
  STARTING_HAND_SIZE = 2
  MENU_WIDTH = 30

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    loop do
      discard_hands
      play_round
      puts '-' * MENU_WIDTH
      break unless player.continue?
    end
    puts 'Goodbye!'
  end

  def discard_hands
    [player, dealer].each(&:discard_hand)
  end

  private

  attr_reader :player, :dealer, :deck

  def play_round
    deal_starting_hand && show_hands
    player_turn
    dealer_turn unless player.busted?
    show_hands(hide_cards: false)
    puts winner
  end

  def winner
    if [player, dealer].any?(&:busted?)
      "#{[player, dealer].min.name} won!"
    elsif player == dealer
      "It's a tie!"
    else
      "#{[dealer, player].max.name} won!"
    end
  end

  def dealer_turn
    dealer.draw_card(deck) until dealer.stay?
  end

  def player_turn
    loop do
      choice = player.prompt
      break if choice == 's'

      player.draw_card(deck)
      break if player.busted?

      show_hands
    end
  end

  def print_welcome_message
    system 'clear'
    puts ' Welcome to 21! '.center(MENU_WIDTH, '=')
  end

  def show_hands(hide_cards: true)
    print_welcome_message
    dealer.show_hand(hide_cards: hide_cards)
    player.show_hand
    puts '-' * MENU_WIDTH
  end

  def deal_starting_hand
    STARTING_HAND_SIZE.times do
      player.draw_card(deck)
      dealer.draw_card(deck)
    end
  end
end

Game.new.play
