# frozen_string_literal: true

# Board to store choices and show visual to Player.
class Board
  attr_reader :grid

  WINS = [
    %i[a1 a2 a3], %i[b1 b2 b3], %i[c1 c2 c3],
    %i[a1 b1 c1], %i[a2 b2 c2], %i[a3 b3 c3],
    %i[a1 b2 c3], %i[a3 b2 c1]
  ].freeze

  def initialize(grid_values = Array.new(9))
    @grid = {
      a1: grid_values[0], a2: grid_values[1], a3: grid_values[2],
      b1: grid_values[3], b2: grid_values[4], b3: grid_values[5],
      c1: grid_values[6], c2: grid_values[7], c3: grid_values[8]
    }
  end

  def win?(player_mark)
    WINS.any? { |line| grid.fetch_values(*line).all?(player_mark) }
  end

  def winner?
    WINS.any? do |line|
      line_values = grid.fetch_values(*line)
      line_values.uniq.length == 1 &&
        line_values.none?(nil)
    end
  end

  def draw?
    grid.none? { |_coordinate, value| value.nil? }
  end

  def game_over?
    winner? || draw?
  end

  def valid_tile?(choice)
    grid.fetch(choice.to_sym, 'invalid choice').nil?
  end

  def mark_tile(mark, tile)
    grid[tile.to_sym] = mark
  end

  def convert_grid_nils(grid = self.grid)
    grid.transform_values { |tile| tile.nil? ? '_' : tile }
  end

  def display(grid = convert_grid_nils(self.grid))
    puts '  1 2 3 '
    puts "a|#{grid[:a1]}|#{grid[:a2]}|#{grid[:a3]}|"
    puts "b|#{grid[:b1]}|#{grid[:b2]}|#{grid[:b3]}|"
    puts "c|#{grid[:c1]}|#{grid[:c2]}|#{grid[:c3]}|"
  end
end
