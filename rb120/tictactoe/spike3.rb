# frozen_string_literal: true

require 'pry'

module Config
  MENU_WIDTH = 28
  BOARD_WIDTH = 3
  SPACE_NAMES = [*1..(BOARD_WIDTH**2)]
  # ROWS = [*0...BOARD_WIDTH]
  # COLUMNS = [*0...BOARD_WIDTH]

  # TODO: Refactor if not used
  def index(space_name)
    idx = SPACE_NAMES.index(space_name)
    idx.divmod(BOARD_WIDTH)
  end

  def center(message, delimiter = ' ')
    message.center(MENU_WIDTH, delimiter)
  end

  def row_separator
    "\n#{center((['---'] * BOARD_WIDTH).join('+'))}\n"
  end
end

class Cell
  include Config

  attr_reader :row, :column, :space_name, :marker

  def initialize(space_name)
    @space_name = space_name
    @row, @column = index(space_name)
    @marker = false
  end

  def to_s
    "#{marker || space_name}"
  end

  def add_mark(mark)
    @marker = mark
  end

  def last_row?
    row == BOARD_WIDTH - 1
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

  def last_row?
    @cells.all?(&:last_row?)
  end

  def marker
    @cells.first.marker if winning_line?
  end

  def to_s
    center(" #{@cells.join(' | ')} ")
  end
end

class Board
  include Config

  def initialize
    @cells = SPACE_NAMES.map { |cell| Cell.new(cell) }
    @rows = partition_rows.map { |line| Line.new(line) }
    @columns = partition_columns.map { |line| Line.new(line) }
    @diagonals = partition_diagonals.map { |line| Line.new(line) }
  end

  def display
    system 'clear'
    puts center(' Welcome to TicTacToe ', '=')
    puts rows.join(row_separator)
    puts '-' * MENU_WIDTH
  end

  def mark(space_name, marker)
    space(space_name).add_mark(marker)
  end

  def winner?
    vectors.any?(&:winning_line?)
  end

  def winner
    vectors.find(&:winning_line?).marker
  end

  private

  attr_reader :cells, :rows, :columns, :diagonals

  def vectors
    rows + columns + diagonals
  end

  def partition_rows
    cells.group_by(&:row).values
  end

  def partition_columns
    cells.group_by(&:column).values
  end

  def partition_diagonals
    left = cells.group_by(&:left_diagonal?)[true]
    right = cells.group_by(&:right_diagonal?)[true]
    [left, right]
  end

  def space(space_name)
    cells.find { |cell| cell.space_name == space_name }
  end
end

class Game
  def initialize
    @board = Board.new
  end

  def play
    board.display
    until winner?
      player.turn
      computer.turn
    end
    puts winner
  end

  private

  attr_reader :board
end

# Game.new.play
board = Board.new
puts board.winner? == false
[1,2,4].each { |space| board.mark(space, :x) }
board.mark(3, :x)
board.display
puts board.winner? == true
p board.winner
# p board.send(:cells).group_by(&:marked?)

