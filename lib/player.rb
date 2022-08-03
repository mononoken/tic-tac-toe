# frozen_string_literal: true

# User for Tic-tac-toe game.
class Player
  attr_reader :name, :mark, :game
  attr_accessor :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
