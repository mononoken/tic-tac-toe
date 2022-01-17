module WinCondition
  def win?(player, grid)
    if grid[:a1] == player.mark && grid[:a2] == player.mark && grid[:a3] == player.mark
      true
    elsif grid[:b1] == player.mark && grid[:b2] == player.mark && grid[:b3] == player.mark
      true
    elsif grid[:c1] == player.mark && grid[:c2] == player.mark && grid[:c3] == player.mark
      true
    elsif grid[:a1] == player.mark && grid[:b1] == player.mark && grid[:c1] == player.mark
      true
    elsif grid[:a2] == player.mark && grid[:b2] == player.mark && grid[:c2] == player.mark
      true
    elsif grid[:a3] == player.mark && grid[:b3] == player.mark && grid[:c3] == player.mark
      true
    elsif grid[:a1] == player.mark && grid[:b2] == player.mark && grid[:c3] == player.mark
      true
    elsif grid[:a3] == player.mark && grid[:b2] == player.mark && grid[:c1] == player.mark
      true
    else
      false      
    end
  end

  def draw?(grid)
    grid.any? {|coordinate, value| value == nil}
  end
end

module Messagable
  def welcome_msg
    'Welcome to a game of Tic-tac-toe!'
  end

  def first_round_msg(first_player)
    "#{first_player.name} starts. Please input a grid coordinate:"
  end

  def prompt_choice_msg(player)
    "#{player.name}'s turn. Please input a grid coordinate:"
  end

  def show_grid(grid)
    "|_|"
  end
end

class GridDisplay
  attr_reader :grid_display

  def initialize(grid)
    @grid_display =
      "
      |#{grid[:a1]}|#{grid[:a2]}|#{grid[:a3]}|
      |#{grid[:b1]}|#{grid[:b2]}|#{grid[:b3]}|
      |#{grid[:c1]}|#{grid[:c2]}|#{grid[:c3]}|
      "
  end
  
end

class GridBoard
  attr_accessor :grid

  def initialize
    @grid = {
      a1: nil, a2: nil, a3: nil,
      b1: nil, b2: nil, b3: nil,
      c1: nil, c2: nil, c3: nil
    }
  end

  def mark_choice(player, choice)
    self.grid[choice.to_sym] = player.mark
  end

  def to_s
    self.grid.transform_values do |tile|
      if tile.nil?
        '_'
      else
        v
      end
    end
  end
end

class Player
  attr_reader :name, :mark, :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def get_choice
    @choice = gets.chomp
  end
end

class Game
  attr_reader :player1, :player2

  def initialize
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @grid = Grid.new
  end
end
