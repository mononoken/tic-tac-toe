# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:empty_board) { described_class.new }

  describe '#valid_tile?' do
    context 'when choice is invalid coordinate' do
      it 'returns false' do
        choice = 'c4'
        expect(empty_board.valid_tile?(choice)).to be(false)
      end
    end

    context 'when choice is invalid number string' do
      it 'returns false' do
        choice = '9000'
        expect(empty_board.valid_tile?(choice)).to be(false)
      end
    end

    context 'when choice is invalid symbol string' do
      it 'returns false' do
        choice = ':test'
        expect(empty_board.valid_tile?(choice)).to be(false)
      end
    end

    context 'when choice exists in grid' do
      it 'returns true' do
        choice = empty_board.grid.keys[0].to_s
        expect(empty_board.valid_tile?(choice)).to be(true)
      end
    end
  end

  describe '#mark_tile' do
    context 'when given a valid tile in grid' do
      it 'changes value of tile to mark' do
        mark = 'x'
        tile = empty_board.grid.keys[0].to_s
        expect { empty_board.mark_tile(mark, tile) }
          .to change { empty_board.grid[tile.to_sym] }.to(mark)
      end
    end
  end

  describe '#convert_grid_nils' do
    context 'when grid tiles are all empty' do
      it 'returns grid hash with all nil values' do
        converted_grid = { a1: '_', a2: '_', a3: '_',
                           b1: '_', b2: '_', b3: '_',
                           c1: '_', c2: '_', c3: '_' }
        expect(empty_board.convert_grid_nils).to eq(converted_grid)
      end
    end

    context 'when grid tiles are partially filled' do
      subject(:mid_game_board) { described_class.new }

      before do
        mid_game_board.mark_tile('x', 'b2')
        mid_game_board.mark_tile('o', 'a3')
        mid_game_board.mark_tile('x', 'a1')
        mid_game_board.mark_tile('o', 'c3')
      end

      it 'returns grid hash with only nil values changed' do
        converted_grid = { a1: 'x', a2: '_', a3: 'o',
                           b1: '_', b2: 'x', b3: '_',
                           c1: '_', c2: '_', c3: 'o' }
        expect(mid_game_board.convert_grid_nils).to eq(converted_grid)
      end
    end
  end

  describe '#winner?' do
    context 'when grid is empty' do
      it 'returns false' do
        expect(empty_board.winner?).to be(false)
      end
    end

    context 'when grid has some non-winning marks' do
      subject(:incomplete_board) do
        described_class.new(['x', 'o', nil, nil, 'o', nil, nil, nil, nil])
      end
      it 'returns false' do
        expect(incomplete_board.winner?).to be(false)
      end
    end

    context "when grid has 'x's across the top" do
      subject(:top_row_board) do
        described_class.new(['x', 'x', 'x', nil, 'o', 'o', 'o', nil, nil])
      end
      it 'returns true' do
        expect(top_row_board.winner?).to be(true)
      end
    end

    context "when grid has 'o's along the left" do
      subject(:left_col_board) do
        described_class.new(['o', 'x', 'x', 'o', 'x', nil, 'o', nil, nil])
      end
      it 'returns true' do
        expect(left_col_board.winner?).to be(true)
      end
    end

    context "when grid has 'o's along a diagonal" do
      subject(:diagonal_board) do
        described_class.new(['o', 'x', 'x', 'x', 'o', nil, nil, nil, 'o'])
      end
      it 'returns true' do
        expect(diagonal_board.winner?).to be(true)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
