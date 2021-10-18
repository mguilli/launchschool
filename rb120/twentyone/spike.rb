# frozen_string_literal: true

# Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.
# Here is an overview of the game:
# - Both participants are initially dealt 2 cards from a 52-card deck.
# - The player takes the first turn, and can "hit" or "stay".
# - If the player busts, he loses. If he stays, it's the dealer's turn.
# - The dealer must hit until his cards add up to at least 17.
# - If he busts, the player wins. If both player and dealer stays, then the highest total wins.
# - If both totals are equal, then it's a tie, and nobody wins.

NUMBERS = (2..10).to_a
FACES = %w(J Q K A)
ACE = 'A'
SUITS = %w(C D H S)
FACE_VALUE = 10
ACE_VALUE = 1
STARTING_HAND_SIZE = 2
BUST = 21

# Card object
class Card
  WRAP_LEFT = '['
  WRAP_RIGHT = ']'
  SEPERATOR = '-'

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
    "[#{face}-#{suit}]"
  end

  def self.hidden
    "[?-?]"
  end

  private

  def card_value
    return(face) unless FACES.include? face

    face == ACE ? ACE_VALUE : FACE_VALUE
  end
end

# Tracks the remaining cards in a deck
class Deck
  def initialize
    cards = (NUMBERS + FACES).product(SUITS)
    @cards = cards.map { |attributes| Card.new(*attributes) }
    shuffle
  end

  def deal_card
    shuffle if cards.empty?
    cards.pop
  end

  private

  def shuffle
    cards.shuffle!
  end

  attr_reader :cards
end

# Tracks player hands
class Participant
  def initialize
    @name = choose_name
    @hand = []
  end

  def draw_card(deck)
    @hand << deck.deal_card
  end

  def show_hand(hide_cards: false)
    first_card = hide_cards ? Card.new('?', '?'): @hand.first

    cards = @hand[1..-1].map(&:to_s).join
    print "#{@name}: #{first_card}#{cards}"
    puts(hide_cards ? '' : " = #{hand_total}")
  end

  def busted?
    hand_total > BUST
  end

  private

  def hand_total
    total = @hand.sum(&:value)
    total_max_ace = total + FACE_VALUE
    total = total_max_ace if @hand.any?(&:ace?) && (total_max_ace <= BUST)

    total
  end
end

class Dealer < Participant
  def choose_name; 'Dealer'; end
end

class Player < Participant
  def choose_name; 'Player'; end
end

# Contains the game logic particular to the Twenty-One game
class Game
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    deal_starting_hand
    show_hands
    player_turn
    # dealer_turn unless player.busted?
    # show_hands(hide_cards: false)
    # determine_winner
  end

  private

  attr_reader :player, :dealer, :deck

  def player_turn
    loop do
      choice = prompt_player
      break if choice == 's'

      player.draw_card(deck)
      break if player.busted?

      show_hands
    end
  end

  def prompt_player
    choice = nil
    loop do
      puts "Hit or Stay (h/s)?"
      choice = gets.chomp
      break if %w(h s).include? choice

      puts 'Incorrect selection. Choose hit or stay (h/s)...'
    end
    choice
  end

  def print_welcome_message
    system 'clear'
    puts '=== Welcome to 21! ==='
  end

  def show_hands(hide_cards: true)
    print_welcome_message
    dealer.show_hand(hide_cards: hide_cards)
    player.show_hand
    puts '------'
  end

  def deal_starting_hand
    STARTING_HAND_SIZE.times do
      player.draw_card(deck)
      dealer.draw_card(deck)
    end
  end
end

# deck = Deck.new
# deck.instance_variable_get(:@cards).each {|card| puts "#{card} : #{card.value}"}

Game.new.play
