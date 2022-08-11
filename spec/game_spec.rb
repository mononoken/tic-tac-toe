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

    context 'when current_player is player1' do
      subject(:started_game) { described_class.new }
      before do
        started_game.current_player = started_game.player1
      end

      it 'sets current_player to player2' do
        expect { started_game.set_current_player }.to \
          change { started_game.current_player }
          .from(started_game.player1).to(started_game.player2)
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

  # DON'T PANIC
  describe '#run_game' do
    context 'when game_over? is false 5 times' do
      subject(:five_round_game) { described_class.new(board) }
      let(:board) { instance_double(Board) }
      before do
        allow(five_round_game).to receive(:end_game)
        allow(five_round_game).to receive(:run_round)
        allow(board).to receive(:game_over?)
          .and_return(false, false, false, false, false, true)
      end

      it 'loops run_round 5 times' do
        expect(five_round_game).to receive(:run_round).exactly(5).times
        five_round_game.run_game
      end
    end

    context 'when game_over? is false 8 times' do
      subject(:eight_round_game) { described_class.new(board) }
      let(:board) { instance_double(Board) }
      before do
        allow(eight_round_game).to receive(:end_game)
        allow(eight_round_game).to receive(:run_round)
        allow(board).to receive(:game_over?)
          .and_return(false, false, false, false, false, false, false, false, true)
      end

      it 'loops run_round 8 times' do
        expect(eight_round_game).to receive(:run_round).exactly(8).times
        eight_round_game.run_game
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
