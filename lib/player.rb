class Player
  attr_reader :name, :mark, :game
  attr_accessor :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end
