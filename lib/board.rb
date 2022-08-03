# frozen_string_literal: true

# Board to store choices and show visual to Player.
class Board
  attr_reader :grid

  def initialize
    @grid = {
      a1: nil, a2: nil, a3: nil,
      b1: nil, b2: nil, b3: nil,
      c1: nil, c2: nil, c3: nil
    }
  end

  def valid_tile?(choice)
    if choice.nil?
      false
    else
      grid.fetch(choice.to_sym, 'invalid choice').nil?
    end
  end

  def mark_tile(mark, location)
    grid[location.to_sym] = mark
  end

  def display(grid = convert_grid_nils(self.grid))
    puts '  1 2 3 '
    puts "a|#{grid[:a1]}|#{grid[:a2]}|#{grid[:a3]}|"
    puts "b|#{grid[:b1]}|#{grid[:b2]}|#{grid[:b3]}|"
    puts "c|#{grid[:c1]}|#{grid[:c2]}|#{grid[:c3]}|"
  end

  def convert_grid_nils(grid = self.grid)
    grid.transform_values { |tile| tile.nil? ? '_' : tile }
  end
end
