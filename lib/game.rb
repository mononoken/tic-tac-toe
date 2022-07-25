# frozen_string_literal: true

require './lib/player'
require './lib/board'

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
    "#{winner.name} wins!"
  end

  def draw_msg
    'Game ended in a draw.'
  end
end

class Game
  include Messagable
  attr_reader :player1, :player2
  attr_accessor :board, :current_player

  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new(self, 'Player 1', 'x')
    @player2 = Player.new(self, 'Player 2', 'o')
    @current_player = nil
  end

  def intro
    puts welcome_msg
    puts instruction_msg
    puts announce_players_msg(player1, player2)
    set_current_player
  end

  def run_game
    intro
    run_round until game_over?
    board.display
    announce_results
    prompt_replay
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

  def announce_results
    if winner?
      puts announce_winner(winner)
    elsif draw?
      puts draw_msg
    end
  end

  # This looks sus.
  # I think it should create a new instance of Board. Also, think it will
  # require to revise how Player chooses things with their choice not stored
  # in player but in Game.
  def reset_game
    new_game = Game.new
    new_game.run_game
  end

  def exit_game
    puts 'Game over. Thanks for playing!'
  end

  def win?(player)
    wins = [
      %i[a1 a2 a3], %i[b1 b2 b3], %i[c1 c2 c3],
      %i[a1 b1 c1], %i[a2 b2 c2], %i[a3 b3 c3],
      %i[a1 b2 c3], %i[a3 b2 c1]
    ]
    wins.any? { |line| board.grid.fetch_values(*line).all?(player.mark) }
  end

  def winner
    if win?(player1)
      player1
    elsif win?(player2)
      player2
    end
  end

  def winner?
    win?(player1) || win?(player2)
  end

  def draw?(grid = board.grid)
    grid.none? { |_coordinate, value| value.nil? }
  end

  def game_over?
    winner? || draw?(board.grid)
  end
end
