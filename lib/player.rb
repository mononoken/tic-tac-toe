class Player
  attr_reader :name, :mark, :game
  attr_accessor :choice

  @@valid_choices = %w[a1 a2 a3 b1 b2 b3 c1 c2 c3]

  def initialize(game, name, mark)
    @game = game
    @name = name
    @mark = mark
    @choice = nil
  end

  def valid_choice?(choice)
    self.game.board.grid.fetch(choice.to_sym).nil?
  end

  def set_choice
    choice = gets.chomp.downcase
    self.choice = if valid_choice?(choice)
                    choice
                  else
                    nil
                  end
  end
end
