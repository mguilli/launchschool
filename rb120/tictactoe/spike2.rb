# frozen_string_literal: true

require 'pry'

module Accessible
  MENU_WIDTH = 28
  BOARD_WIDTH = 3
  SPACE_NAMES = [*1..(BOARD_WIDTH**2)]
  ROWS = [*0...BOARD_WIDTH]
  COLUMNS = [*0...BOARD_WIDTH]
  # DIAGONALS = [0, 1]

  def index(space_name)
    idx = SPACE_NAMES.index(space_name)
    idx.divmod(BOARD_WIDTH)
  end
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

  def left_diagonal?
    row == column
  end

  def right_diagonal?
    row + column == BOARD_WIDTH - 1
  end
end

class Line
  def initialize(cell_array)
    @cells = cell_array
  end

  def winning_line?
    @cells.all?(&:marked?) && @cells.group_by(&:marker).size == 1
  end
end

class Group
  def initialize(line_array)
    @lines = line_array.map { |line| Line.new(line) }
  end

  def winning_line?
    @lines.any?(&:winning_line?)
  end
end

class Board
  include Accessible

  def initialize
    @cells = SPACE_NAMES.map { |cell| Cell.new(cell) }
    @rows = Group.new(partition_rows)
    @columns = Group.new(partition_columns)
    @diagonals = Group.new(partition_diagonals)
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
    # [rows, columns, diagonals].any? do |group|
    #   group.any? { |line| winning_line?(line) }
    # end
    [rows, columns, diagonals].any?(&:winning_line?)
  end

  def winner
    winning_line = [rows, columns, diagonals].map do |group|
      group.select { |line| winning_line?(line) }
    end
    winning_marker = winning_line.flatten.first.marker
    winning_marker
  end

  private

  attr_reader :cells, :rows, :columns, :diagonals

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
[1,2,4].each { |space| board.mark(space, :x) }
board.mark(3, :x)
# board.display
puts board.winner? == true
p board.winner
p board.send(:cells).group_by(&:marked?)
