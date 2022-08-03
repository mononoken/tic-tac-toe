class Player
  attr_reader :name, :mark, :game
  attr_accessor :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
    @choice = nil
  end



  def set_choice
    choice = gets.chomp.downcase
    self.choice = choice if valid_choice?(choice)
  end
end
