# frozen_string_literal: true

# Board to store choices and show visual to Player.
class Board
  attr_reader :grid

  def initialize(grid_values = Array.new(9))
    @grid = {
      a1: grid_values[0], a2: grid_values[1], a3: grid_values[2],
      b1: grid_values[3], b2: grid_values[4], b3: grid_values[5],
      c1: grid_values[6], c2: grid_values[7], c3: grid_values[8]
    }
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
