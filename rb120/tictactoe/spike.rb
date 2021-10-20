# frozen_string_literal: true

module Accessible
  WIDTH = 3
  SPACE_NAMES = [*1..(WIDTH**2)]
  ROWS = [*0...WIDTH]
  COLUMNS = [*0...WIDTH]
  DIAGONALS = [*0...(WIDTH - 1)]

  def index(space_name)
    idx = SPACE_NAMES.index(space_name)
    idx.divmod(WIDTH)
  end

  # def row_column(space_name)
  #   row, column = index(space_name)
  #   [ROWS[row], COLUMNS[column]]
  # end
end

class Cell
  include Accessible

  attr_reader :row, :column, :space_name, :marker

  def initialize(space_name)
    @space_name = space_name
    @row, @column = index(space_name)
  end

  def to_s
    " #{marker || space_name} "
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
    ROWS.map { |name| cells.select { |cell| cell.row == name } }
  end

  def columns
    rows.transpose
  end

  def diagonals
    first = cells.select { |cell| cell.row == cell.column }
    second = cells.select { |cell| (cell.row + cell.column) == (WIDTH - 1) }
    [first, second]
  end

  def display
    rows.each do |row|
      puts row.join('|')
      break if row.last.last_row?
      puts '---+---+---'
    end
  end

  def mark(space_name, marker)
    space(space_name).add_mark(marker)
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
  end

  private

  attr_reader :board
end

Game.new.play
board = Board.new
p(board.rows.map { |row| row.map(&:space_name) })
p(board.columns.map { |row| row.map(&:space_name) })
p(board.diagonals.map { |row| row.map(&:space_name) })
p board.rows
