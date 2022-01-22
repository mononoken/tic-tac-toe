class Player
  attr_reader :name, :mark, :game
  attr_accessor :choice

  def initialize(game, name, mark)
    @game = game
    @name = name
    @mark = mark
    @choice = nil
  end

  def valid_choice?(choice)
    if choice.nil?
      false
    else
      self.game.board.grid.fetch(choice.to_sym, 'invalid choice').nil?
    end
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
