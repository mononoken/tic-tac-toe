module WinCondition
  def win?(player, grid)
    if grid[:a1] == player.mark && grid[:a2] == player.mark && grid[:a3] == player.mark
      true
    elsif grid[:b1] == player.mark && grid[:b2] == player.mark && grid[:b3] == player.mark
      true
    elsif grid[:c1] == player.mark && grid[:c2] == player.mark && grid[:c3] == player.mark
      true
    elsif grid[:a1] == player.mark && grid[:b1] == player.mark && grid[:c1] == player.mark
      true
    elsif grid[:a2] == player.mark && grid[:b2] == player.mark && grid[:c2] == player.mark
      true
    elsif grid[:a3] == player.mark && grid[:b3] == player.mark && grid[:c3] == player.mark
      true
    elsif grid[:a1] == player.mark && grid[:b2] == player.mark && grid[:c3] == player.mark
      true
    elsif grid[:a3] == player.mark && grid[:b2] == player.mark && grid[:c1] == player.mark
      true
    else
      false      
  end
end

class GridBoard
  attr_accessor :grid

  def initialize
    @grid = {
      a1: nil, a2: nil, a3: nil,
      b1: nil, b2: nil, b3: nil,
      c1: nil, c2: nil, c3: nil
    }
  end

  def mark_choice(player, choice)
    self.grid[choice.to_sym] = player.mark
  end
end

class Player
  attr_reader :name, :mark
  attr_accessor :choice

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def get_choice
    @choice = gets.chomp
  end
end

grid = GridBoard.new
p grid
player1 = Player.new("Player1", "X")
player1.choice = "a1"
grid.mark_choice(player1, player1.choice)
p grid
