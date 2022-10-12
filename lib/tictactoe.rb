# frozen-string-literal: true

# Game handler
class TicTacToe
  LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9],
           [1, 5, 9], [7, 5, 3]].freeze

  def initialize(player_class1, player_class2)
    @grid = Array.new(10)
    @players = [player_class1.new(self, 'X'), player_class2.new(self, 'O')]
  end

  def play
    print_board
    until game_over?
      n = n == 0 ? 1 : 0

      get_player_input(n)
      print_board
    end
  end

  def place_mark(player, cell)
    # return false unless @grid[cell]
    if free_cell?(cell)
      @grid[cell] = player.marker
    else
      false
    end
  end

  private

  def get_player_input(num)
    puts "#{@players[num].marker} choose:"
    while choice = @players[num].select_position
      if free_cell?(choice)
        place_mark(@players[num], choice)
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

  def full_line?
    LINES.each do |line|
      result = line.map { |i| @grid[i] }.uniq

      return result.first if result.count == 1 && result[0]
    end
    false
  end

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

  def free_cell?(cell)
    cell.between?(1, 9) && @grid[cell].nil?
  end
end
