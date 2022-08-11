# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:new_game) { described_class.new }

  describe '#set_current_player' do
    context 'when current_player is nil' do
      it 'sets current_player to a random player' do
        expect { new_game.set_current_player }.to \
          change { new_game.current_player }
          .from(nil).to(new_game.player1)
          .or change { new_game.current_player }
          .from(nil).to(new_game.player2)
      end
    end

    # This is not actually a new game so should I make a new variable for it?
    context 'when current_player is player1' do
      before do
        new_game.current_player = new_game.player1
      end

      it 'sets current_player to player2' do
        expect { new_game.set_current_player }.to \
          change { new_game.current_player }
          .from(new_game.player1).to(new_game.player2)
      end
    end

    context 'when current_player is player2' do
      before do
        new_game.current_player = new_game.player2
      end

      it 'sets current_player to player1' do
        expect { new_game.set_current_player }.to \
          change { new_game.current_player }
          .from(new_game.player2).to(new_game.player1)
      end
    end
  end

  # describe '#win?' do
  #   context "when board is marked 'x' in a1 a2 a3" do
  #     subject(:finished_game) { described_class.new(finished_board) }
  #     let(:finished_board) { instance_double(Board) }

  #     before do
  #     end

  #     it 'blanks' do
  #     end
  #   end
  # end
end

# rubocop:enable Metrics/BlockLength
