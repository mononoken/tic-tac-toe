require './lib/player'
require './lib/board'

module EndCondition
  def win?(player, board)
    if board[:a1] == player.mark && board[:a2] == player.mark && board[:a3] == player.mark
      true
    elsif board[:b1] == player.mark && board[:b2] == player.mark && board[:b3] == player.mark
      true
    elsif board[:c1] == player.mark && board[:c2] == player.mark && board[:c3] == player.mark
      true
    elsif board[:a1] == player.mark && board[:b1] == player.mark && board[:c1] == player.mark
      true
    elsif board[:a2] == player.mark && board[:b2] == player.mark && board[:c2] == player.mark
      true
    elsif board[:a3] == player.mark && board[:b3] == player.mark && board[:c3] == player.mark
      true
    elsif board[:a1] == player.mark && board[:b2] == player.mark && board[:c3] == player.mark
      true
    elsif board[:a3] == player.mark && board[:b2] == player.mark && board[:c1] == player.mark
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
      'Each player will take turns choosing board coordinates to place their marks.',
      "board coordinate inputs must be formatted similar to these examples: 'a1' 'b2'."
    ]
  end

  def prompt_choice_msg(player)
    "#{player.name}'s turn. Please input a board coordinate:"
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
  attr_accessor :board, :current_player

  def initialize
    @player1 = Player.new(self, 'Player 1', 'x')
    @player2 = Player.new(self, 'Player 2', 'o')
    @board = Board.new
    @current_player = nil
  end

  def set_current_player
    self.current_player = if self.current_player == self.player1
                            self.player2
                          else
                            self.player1
                          end
  end

  def intro
    puts welcome_msg
    puts instruction_msg
    puts announce_players_msg(self.player1, self.player2)
    @current_player = self.player2
  end

  def run_round
    set_current_player
    self.board.display_board
    set_player_input
    self.board.mark_choice(self.current_player, self.current_player.choice)
  end

  def set_player_input
    loop do
      puts prompt_choice_msg(self.current_player)
      player_choice = self.current_player.set_choice
      break if self.current_player.valid_choice?(player_choice)
    end
  end

  def run_game
    intro
    run_round until self.win?(self.current_player, self.board.grid) || self.draw?(self.board.grid)
    self.board.display_board
    if self.win?(self.player1, self.board.grid)
      winner = self.player1
      puts announce_winner(winner)
    elsif self.win?(self.player2, self.board.grid)
      winner = self.player2
      puts announce_winner(winner.name)
    elsif self.draw?(self.board.grid)
      puts draw_msg
    else
      puts 'What happened?'
    end
  end
end

test_game = Game.new
test_game.run_game
