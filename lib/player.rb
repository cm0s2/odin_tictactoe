# Player class
class Player
  attr_reader :marker

  def initialize(game, marker)
    @game = game
    @marker = marker
  end

  def select_position
    loop do
      puts "#{marker} chooses:"
      cell = gets.to_i
      return cell if cell.between?(1, 9)
    end
  end
end