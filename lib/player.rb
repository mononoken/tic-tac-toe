class Player
  attr_reader :name, :mark
  attr_accessor :choice

  @@valid_choices = %w[a1 a2 a3 b1 b2 b3 c1 c2 c3]

  def initialize(name, mark)
    @name = name
    @mark = mark
    @choice = nil
  end

  def valid_choice?(choice)
    @@valid_choices.include?(choice)
  end

  def set_choice
    self.choice = gets.chomp.downcase
    if valid_choice?(self.choice)
      @@valid_choices.delete(self.choice)
    else
      self.choice = nil
    end
  end
end
