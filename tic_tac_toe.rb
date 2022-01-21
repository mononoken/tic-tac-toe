require player.rb
require board.rb

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
    grid.none? { |_coordinate, value| value.nil? }
  end
end

module Messagable
  def welcome_msg
    'Welcome to a game of Tic-tac-toe!'
  end

  def announce_players_msg(first_player, second_player)
    [
      "#{first_player.name} is assigned #{first_player.mark}.",
      "#{second_player.name} is assigned #{second_player.mark}."
    ]
  end

  def instruction_msg
    [
      'Each player will take turns choosing grid coordinates to place their marks.',
      "Grid coordinate inputs must be formatted similar to these examples: 'a1' 'b2'."
    ]
  end

  def prompt_choice_msg(player)
    "#{player.name}'s turn. Please input a grid coordinate:"
  end

  def announce_winner(winner)
    "#{winner} wins!"
  end

  def draw_msg
    'Game ended in a draw.'
  end
end

class Game
  include EndCondition
  include Messagable
  attr_reader :player1, :player2
  attr_accessor :grid, :current_player

  def initialize
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @grid = Board.new
    @current_player = nil
  end

  def set_current_player
    if self.current_player == self.player1
      self.current_player = self.player2
    else
      self.current_player = self.player1
    end
  end

  def run_round
    set_current_player
    self.grid.display_board
    puts prompt_choice_msg(self.current_player)
    self.current_player.set_choice
    self.grid.mark_choice(self.current_player, self.current_player.choice)
  end

  def run_game
    puts welcome_msg
    puts instruction_msg
    puts announce_players_msg(self.player1, self.player2)
    @current_player = self.player2
    run_round until self.win?(self.current_player, self.grid.grid) || self.draw?(self.grid.grid)
    self.grid.display_board
    if self.win?(self.player1, self.grid.grid)
      winner = self.player1
      puts announce_winner(winner)
    elsif self.win?(self.player2, self.grid.grid)
      winner = self.player2
      puts announce_winner(winner.name)
    elsif self.draw?(self.grid.grid)
      puts draw_msg
    else
      puts 'What happened?'
    end
  end
end

test_game = Game.new
test_game.run_game
