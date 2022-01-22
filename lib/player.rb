class Player
  attr_reader :name, :mark
  attr_accessor :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
    @choice = nil
  end

  def set_choice
    self.choice = gets.chomp.downcase
  end

  def valid_choice?(choice)
    valid_choices = %w[a1 a2 a3 b1 b2 b3 c1 c2 c3]
    valid_choices.include?(choice)
  end
end
