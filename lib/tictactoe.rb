# frozen-string-literal: true

# Game handler
class TicTacToe
  LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9],
           [1, 5, 9], [7, 5, 3]].freeze

  def initialize(player_class1: Player, player_class2: Player, grid: Array.new(10))
    @grid = grid
    @player1 = player_class1.new(self, 'X')
    @player2 = player_class2.new(self, 'O')
    @current_player = @player1
  end

  def play
    print_board
    turn_order until game_over?
  end

  def turn_order
    player_input(@current_player)
    switch_player
    print_board
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def place_mark(player, cell)
    @grid[cell] = player.marker
  end

  def player_input(player)
    puts "#{player.marker} choose:"
    loop do
      choice = player.select_position
      if valid_cell?(choice)
        place_mark(player, choice)
        break
      end
    end
  end

  def game_over?
    if board_full?
      puts 'Board full'
      return true
    elsif full_line?
      puts "Full line, #{full_line?} won"
      return true
    end
    false
  end

  def board_full?
    return true if @grid[1..9].compact.size == 9

    false
  end

  def full_line?(grid = @grid)
    LINES.each do |line|
      result = line.map { |i| grid[i] }.uniq

      return result.first if result.count == 1 && result[0]
    end
    false
  end

  def valid_cell?(cell)
    cell.between?(1, 9) && @grid[cell].nil?
  end

  private

  def print_board
    puts " #{cell(1)} | #{cell(2)} | #{cell(3)}\n" \
         "---+---+---\n" \
         " #{cell(4)} | #{cell(5)} | #{cell(6)}\n" \
         "---+---+---\n" \
         " #{cell(7)} | #{cell(8)} | #{cell(9)}\n"
  end

  def cell(cell)
    @grid[cell] || ' '
  end
end
