# frozen_string_literal: true

# Board to store choices and show visual to Player.
class Board
  attr_accessor :grid

  def initialize
    @grid = {
      a1: nil, a2: nil, a3: nil,
      b1: nil, b2: nil, b3: nil,
      c1: nil, c2: nil, c3: nil
    }
  end

  # This method belongs in Game.
  def mark_choice(player, choice)
    grid[choice.to_sym] = player.mark
  end

  def convert_grid_nils
    grid.transform_values do |tile|
      if tile.nil?
        '_'
      else
        tile
      end
    end
  end

  def display
    converted_grid = convert_grid_nils
    puts '  1 2 3 '
    puts "a|#{converted_grid[:a1]}|#{converted_grid[:a2]}|#{converted_grid[:a3]}|"
    puts "b|#{converted_grid[:b1]}|#{converted_grid[:b2]}|#{converted_grid[:b3]}|"
    puts "c|#{converted_grid[:c1]}|#{converted_grid[:c2]}|#{converted_grid[:c3]}|"
  end

  def valid_choice?(choice)
    if choice.nil?
      false
    else
      grid.fetch(choice.to_sym, 'invalid choice').nil?
    end
  end
end
