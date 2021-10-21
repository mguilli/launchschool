# frozen_string_literal: true

require 'pry'

module Accessible
  MENU_WIDTH = 28
  BOARD_WIDTH = 3
  SPACE_NAMES = [*1..(BOARD_WIDTH**2)]
  ROWS = [*0...BOARD_WIDTH]
  COLUMNS = [*0...BOARD_WIDTH]
  DIAGONALS = [0, 1]

  def index(space_name)
    idx = SPACE_NAMES.index(space_name)
    idx.divmod(BOARD_WIDTH)
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
    @marker = false
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

  def marked?
    marker ? true : false
  end
end

class Board
  include Accessible

  def initialize
    @cells = SPACE_NAMES.map { |cell| Cell.new(cell) }
  end

  def display
    system 'clear'
    puts center(' Welcome to TicTacToe ', '=')

    rows.each do |row|
      puts center(row.join('|'))
      break if row.last.last_row?

      puts center((['---'] * BOARD_WIDTH).join('+'))
    end

    puts '-' * MENU_WIDTH
  end

  def mark(space_name, marker)
    space(space_name).add_mark(marker)
  end

  def winner?
    [rows, columns, diagonals].any? do |group|
      group.any? { |line| winning_line?(line) }
    end
  end

  def winner
    winning_line = [rows, columns, diagonals].map do |group|
      group.select { |line| winning_line?(line) }
    end
    winning_marker = winning_line.flatten.first.marker
    winning_marker
  end

  private

  attr_reader :cells

  def winning_line?(line)
    line.all?(&:marked?) && line.map(&:marker).uniq.size == 1
  end

  def rows
    ROWS.map { |name| cells.select { |cell| cell.row == name }.keys }
  end

  def columns
    rows.transpose
  end

  def diagonals
    left = cells.select { |cell| (cell.row + cell.column) == (BOARD_WIDTH - 1) }
    right = cells.select { |cell| cell.row == cell.column }
    [left, right]
  end

  def center(message, delimiter = ' ')
    message.center(MENU_WIDTH, delimiter)
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
[1,4,7].each { |space| board.mark(space, :x) }
puts board.winner? == true
p board.winner
