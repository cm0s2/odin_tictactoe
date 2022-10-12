
require_relative '../lib/player'

describe Player do
  let(:marker) { 'X' }
  subject(:player) { described_class.new(nil, marker) }

  describe '#select_position' do

    matcher :be_between_one_and_nine do
      match { |number| number.between?(1, 9) }
    end

    context 'When valid input is provided' do
      before do
        player_input = '5'
        allow(player).to receive(:gets).and_return(player_input)
      end

      it 'returns a cell number between 1 and 9' do
        expect(player.select_position).to eq(5)
      end
    end

    context 'When user inputs an incorrect value once, then a valid input' do
      before do
        invalid_input = 'a'
        valid_input = '5'
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'completes loop once and displays error message' do
        error_message = "Error: Please enter a number between 1 and 9"
        expect(player).to receive(:puts).with(error_message).once
        player.select_position
        #expect(player.select_position).to eq(5)
      end
    end
  end
end