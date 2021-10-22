# frozen_string_literal: true

require 'pry'

module Config
  MENU_WIDTH = 28
  BOARD_WIDTH = 3
  SPACE_NAMES = [*1..(BOARD_WIDTH**2)]

  def center_string(message, delimiter = ' ')
    message.center(MENU_WIDTH, delimiter)
  end

  def row_separator
    "\n#{center_string((['---'] * BOARD_WIDTH).join('+'))}\n"
  end
end

class Cell
  include Config

  attr_reader :row, :column, :space_name, :marker

  def initialize(space_name)
    @space_name = space_name
    @row, @column = SPACE_NAMES.index(space_name).divmod(BOARD_WIDTH)
    @marker = false
  end

  def to_s
    (marker || space_name).to_s
  end

  def add_mark(mark)
    @marker = mark
  end

  def marked?
    marker ? true : false
  end

  def left_diagonal?
    row == column
  end

  def right_diagonal?
    row + column == BOARD_WIDTH - 1
  end
end

class Line
  include Config

  def initialize(cell_array)
    @cells = cell_array
  end

  def winning_line?
    @cells.all?(&:marked?) && @cells.group_by(&:marker).size == 1
  end

  def winning_marker
    @cells.first.marker if winning_line?
  end

  def to_s
    center_string(" #{@cells.join(' | ')} ")
  end
end

class Board
  include Config

  def initialize
    @cells = SPACE_NAMES.map { |cell| Cell.new(cell) }
    @rows, @columns, @diagonals = partition_cells
  end

  def display
    system 'clear'
    puts center_string(' Welcome to TicTacToe ', '=')
    puts ''
    puts rows.join(row_separator)
    puts ''
    puts '-' * MENU_WIDTH
  end

  def []=(space_name, marker)
    space(space_name).add_mark(marker)
  end

  def winner?
    vectors.any?(&:winning_line?)
  end

  def winner
    vectors.find(&:winning_line?).winning_marker
  end

  private

  attr_reader :cells, :rows, :columns, :diagonals

  def space(space_name)
    cells.find { |cell| cell.space_name == space_name }
  end

  def vectors
    rows + columns + diagonals
  end

  def partition_cells
    rows = cells.group_by(&:row).values
    cols = cells.group_by(&:column).values
    diag = %i(left_diagonal? right_diagonal?).map do |diagonal|
      cells.group_by(&diagonal)[true]
    end
    [rows, cols, diag].map { |group| group.map { |line| Line.new(line) } }
  end
end

class Player
end

class Computer < Player
end

class Human < Player
end

class Game
  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def play
    board.display
    until board.winner?
      human.turn
      computer.turn
    end
    puts board.winner
  end

  private

  attr_reader :board, :human, :computer
end

Game.new.play
# board = Board.new
# puts board.winner? == false
# [1,2,4].each { |space| board[space] = :x}
# board[3] = :x
# board.display
# puts board.winner? == true
# p board.winner

