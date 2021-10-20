# frozen_string_literal: true

module Accessible
  SPACE_NAMES = (1..9)
  ROWS = %i(top middle bottom)
  COLUMNS = %i(left center right)

  def index(space_number)
    space_number -= 1
    space_number.divmod(3)
  end

  def row_column(space_number)
    row, column = index(space_number)
    [ROWS[row], COLUMNS[column]]
  end
end

class Cell
  include Accessible

  attr_reader :row, :column, :number, :marker

  def initialize(space_number)
    @number = space_number
    @row, @column = row_column(space_number)
    @marker = false
  end

  def to_s
    " #{marker || ' '} "
  end

  def add_mark(mark)
    @marker = mark
  end

  def last_row?
    row == ROWS.last
  end
end

class Board
  include Accessible
  # Diagonals: row == column || (row + column) == 2

  attr_reader :cells

  def initialize
    @cells = SPACE_NAMES.map { |cell| Cell.new(cell) }
  end

  def rows
    # cells.each_slice(3).to_a
    ROWS.map { |name| cells.select { |cell| cell.row == name } }
  end

  def display
    rows.each do |row|
      puts row.join('|')
      break if row.first.last_row?
      puts '---+---+---'
    end
  end

  def mark(number, marker)
    cell = find_by_number(number)
    cell.add_mark(marker)
  end

  def find_by_number(number)
    cells.find { |cell| cell.number == number }
  end
end

class Game
  def initialize
    @board = Board.new
  end

  def play
    board.display
    board.mark(5, 'x')
    board.display
    board.mark(9, 'o')
    board.display
    board.mark(4, 'x')
    board.display
  end

  private

  attr_reader :board
end

Game.new.play
