require_relative '../lib/tictactoe'
require_relative '../lib/player'

describe TicTacToe do

  subject(:game) { described_class.new }

  describe '#play' do
    # Public Script Method -> No test necessary, but all methods inside should
    # be tested.
  end

  describe '#turn_order' do
    it 'sends player_input' do
      current_player = game.instance_variable_get(:@current_player)
      expect(game).to receive(:player_input).with(current_player).once
      game.turn_order
    end
  end

  describe '#switch_player' do
    it 'changes current_player from player1 to player2' do
      game.switch_player
      player2 = game.instance_variable_get(:@player2)
      current_player = game.instance_variable_get(:@current_player)
      expect(current_player).to eql(player2)
    end
  end

  describe '#place_mark' do
    let(:player) { double('player') }
    
    it 'places a marker X in specified cell' do
      marker = 'X'
      allow(player).to receive(:marker).and_return(marker)
      cell = 1
      game.place_mark(player, cell)

      grid = game.instance_variable_get(:@grid)
      cell_value = grid[cell]
      expect(cell_value).to eq(marker)
    end
  end

  describe '#player_input' do
  end

  describe '#game_over?' do
    context 'when board is neither full nor a line is full' do
      it 'returns false' do
        allow(game).to receive(:board_full?).and_return(false)
        allow(game).to receive(:full_line?).and_return(false)
        expect(game).not_to be_game_over 
      end
    end

    context 'when board is not full but a line is full' do
      it 'is game over' do
        allow(game).to receive(:board_full?).and_return(false)
        allow(game).to receive(:full_line?).and_return(true)
        expect(game).to be_game_over 
      end
    end

    context 'when board is full and a line is full' do
      it 'is game over' do
        allow(game).to receive(:board_full?).and_return(true)
        allow(game).to receive(:full_line?).and_return(true)
        expect(game).to be_game_over 
      end
    end
  end

  describe '#board_full?' do
    
    context 'when board is full' do
      subject(:game_full) { described_class.new(grid: [nil, 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']) }
      it 'returns true' do
        expect(game_full).to be_board_full
      end
    end

    context 'when board is not full' do
      it 'returns false' do
        
        expect(game).not_to be_board_full
      end
      
    end
    
  end

  describe '#full_line?' do
    context 'when board it empty' do
      it 'returns false' do
        expect(game).not_to be_full_line
      end
    end

    context 'when X has a diagonal line' do
      let(:grid_diagonal) { [nil, 'X', 'O', nil, 'O', 'X', nil, nil, nil, 'X'] }
      it 'returns X' do
        expect(game.full_line?(grid_diagonal)).to eq('X')
      end
    end

    context 'when O has a horizontal line' do
      let(:grid_horizontal) { [nil, 'X', nil, 'X', 'O', 'O', 'O', nil, nil, 'X'] }
      it 'returns O' do
        expect(game.full_line?(grid_horizontal)).to eq('O')
      end
    end

    context 'when X has a vertical line' do
      let(:grid_vertical) { [nil, 'X', 'O', nil, 'X', 'O', nil, 'X', nil, nil] }
      it 'returns X' do
        expect(game.full_line?(grid_vertical)).to eq('X')
      end
    end
  end

  describe '#valid_cell?' do
    context 'when cell is valid' do
      it 'returns true' do
        result = game.valid_cell?(1)
        expect(result).to be true
      end
    end

    context 'when cell is outside board' do
      it 'returns false' do
        result = game.valid_cell?(10)
        expect(result).to be false
      end
    end

    context 'when cell is already taken' do
      let(:player) { double('player') }

      before do
        allow(player).to receive(:marker).and_return('X')
        game.place_mark(player, 1)
      end

      it 'returns false' do
        result = game.valid_cell?(1)
        expect(result).to be false
      end
    end
  end

end
