# frozen_string_literal: true

require './lib/player'
require './lib/board'

# Store string messages outside of game.
module Messagable
  def intro_msg
    [
      'Welcome to a game of Tic-tac-toe!',
      'Each player will take turns choosing board coordinates to place their marks.',
      "Board coordinate inputs must be formatted similar to these examples: 'a1' 'b2'."
    ]
  end

  def announce_players_msg(first_player, second_player)
    [
      "#{first_player.name} is assigned #{first_player.mark}.",
      "#{second_player.name} is assigned #{second_player.mark}."
    ]
  end

  def prompt_choice_msg(player)
    "#{player.name}'s turn. Please input a board coordinate:"
  end

  def announce_winner(winner)
    "#{winner.name} wins!"
  end

  def draw_msg
    'Game ended in a draw.'
  end
end

# Game of Tic-tac-toe.
class Game
  include Messagable

  attr_reader :player1, :player2
  attr_accessor :board, :current_player

  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new('Player 1', 'x')
    @player2 = Player.new('Player 2', 'o')
    @current_player = nil
  end

  def intro
    puts intro_msg
    puts announce_players_msg(player1, player2)
    set_current_player
  end

  def start_game
    intro
    run_game
  end

  def run_game
    run_round until board.game_over?
    end_game
  end

  def end_game
    board.display
    announce_results
    prompt_replay
  end

  def run_round
    set_current_player
    board.display
    board.mark_tile(current_player.mark, player_input)
  end

  def player_input(player_choice = nil)
    loop do
      puts prompt_choice_msg(current_player)
      player_choice = gets.chomp.downcase

      break if board.valid_tile?(player_choice)
    end
    player_choice
  end

  def set_current_player
    self.current_player = if current_player?(player1)
                            player2
                          elsif current_player?(player2)
                            player1
                          else
                            random_player
                          end
  end

  def random_player
    rand(1..2) == 1 ? player1 : player2
  end

  def current_player?(player)
    current_player == player
  end

  def prompt_replay
    puts 'Play again? (y/n)'
    replay_option = gets.chomp.downcase
    case replay_option
    when 'y'
      reset_game
    when 'n'
      exit_game
    else
      prompt_replay
    end
  end

  def reset_game
    @board = Board.new
    run_game
  end

  def winner
    if board.win?(player1.mark)
      player1
    elsif board.win?(player2.mark)
      player2
    end
  end

  private

  def exit_game
    puts 'Game over. Thanks for playing!'
  end

  def announce_results
    if board.winner?
      puts announce_winner(winner)
    elsif board.draw?
      puts draw_msg
    end
  end
end
