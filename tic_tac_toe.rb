module EndCondition
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
    grid.any? { |_coordinate, value| value.nil? }
  end
end

module Messagable
  def welcome_msg
    'Welcome to a game of Tic-tac-toe!'
  end

  def announce_players_msg(first_player, second_player)
    "#{first_player.name} is assigned #{first_player.mark}."
    "#{second_player.name} is assigned #{second_player.mark}."
  end

  def instruction_msg
    'Each player will take turns choosing grid coordinates to place their marks.'
    "Grid coordinates must be formatted similar to these examples: 'a1' 'b2'."
  end

  def first_round_msg(first_player)
    "#{first_player.name} starts. Please input a grid coordinate:"
  end

  def prompt_choice_msg(player)
    "#{player.name}'s turn. Please input a grid coordinate:"
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

  def display_grid
    converted_grid = self.grid.transform_values do |tile|
      if tile.nil?
        '_'
      else
        v
      end
    end
    puts "|#{converted_grid[:a1]}|#{converted_grid[:a2]}|#{converted_grid[:a3]}|"
    puts "|#{converted_grid[:b1]}|#{converted_grid[:b2]}|#{converted_grid[:b3]}|"
    puts "|#{converted_grid[:c1]}|#{converted_grid[:c2]}|#{converted_grid[:c3]}|"
  end
end

class Player
  attr_reader :name, :mark, :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def set_choice
    @choice = gets.chomp
  end
end

class Game
  include EndCondition
  include Messagable
  attr_reader :player1, :player2

  def initialize
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @grid = Grid.new
  end

  def set_current_player
    if @current_player == self.player1
      @current_player = self.player2
    else
      @curent_player = self.player1
  end

  def run_round
    set_current_player
    self.grid.display_grid
    puts prompt_choice_msg
    self.current_player.set_choice
  end

  def run_game
    puts welcome_msg
    puts instruction_msg
    puts announce_players_msg
    run_round until EndCondition.win? || EndCondition.draw?
  end
end
