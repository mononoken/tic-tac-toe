# frozen_string_literal: true

# User for Tic-tac-toe game.
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
