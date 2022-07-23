# frozen_string_literal: true

require './lib/player'
require './lib/board'

module EndCondition
  def win?(player)
    wins = [
      %i[a1 a2 a3], %i[b1 b2 b3], %i[c1 c2 c3],
      %i[a1 b1 c1], %i[a2 b2 c2], %i[a3 b3 c3],
      %i[a1 b2 c3], %i[a3 b2 c1]
    ]
    wins.any? { |line| board.grid.fetch_values(*line).all?(player.mark) }
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
      "Board coordinate inputs must be formatted similar to these examples: 'a1' 'b2'."
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
    self.board.display
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

  def prompt_replay
    puts 'Play again? (y/n)'
    replay_option = gets.chomp.downcase
    case replay_option
    when 'y'
      reset_game
    when 'n'
      exitg_game
    else
      prompt_replay
    end
  end

  def check_end_conditions
    if self.win?(self.current_player)
      puts announce_winner(self.current_player.name)
    elsif self.draw?(self.board.grid)
      puts draw_msg
    end
  end

  # This looks sus.
  def reset_game
    new_game = Game.new
    new_game.run_game
  end

  def exit_game
    puts 'Game over. Thanks for playing!'
  end

  def game_over?
    win?(player1) || win?(player2) || draw?(board.grid)
  end

  def run_game
    intro
    run_round until game_over?
    self.board.displgay
    check_end_conditions
    prompt_replay
  end
end
