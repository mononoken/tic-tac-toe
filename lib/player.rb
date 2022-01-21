class Player
  attr_reader :name, :mark
  attr_accessor :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
    @choice = nil
  end

  def set_choice
    self.choice = gets.chomp
  end
end
