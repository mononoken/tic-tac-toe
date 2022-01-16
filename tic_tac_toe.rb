class GridBoard
  attr_accessor :grid
  def initialize
    @grid = {
    a1: nil, a2: nil, a3: nil,
    b1: nil, b2: nil, b3: nil,
    c1: nil, c2: nil, c3: nil
    }
  end
end