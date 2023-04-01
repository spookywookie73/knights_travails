class Knight
  attr_reader :position
  attr_accessor :children, :parent
  # You are basically creating a node.
  def initialize(position, parent = nil)
    @position = position
    @children = []
    @parent = parent
  end
  # This method loops through the moves and if they fall within a certain range
  # they are added to an array.
  def next_moves
    result = []
    moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    moves.each do |move|
      next_move = [position[0] + move[0], position[1] + move[1]]
      result.push(next_move) if next_move[0].between?(0, 7) && next_move[1].between?(0, 7)
    end
    result
  end

end

class ChessBoard
  
  #def initialize;end
  
  # This method checks if the start and finish positions fall within a certain range,
  # if they do they are then sent to another method.
  def knight_moves(start, finish)
    start_array = []
    finish_array = []
    
    start.each do |num|
      if num.between?(0, 7)
        start_array.push(num)
      else
        return puts 'Choose a number between 0 and 7'
      end
    end

    finish.each do |num|
      if num.between?(0, 7)
        finish_array.push(num)
      else
        return puts 'Choose a number between 0 and 7'
      end
    end
    bfs(start_array, finish_array)
  end
  # This is a Breadth First Search method.
  def bfs(start, finish, path = [], queue = [])
    current = Knight.new(start)
    until current.position == finish
      current.next_moves.each do |move|
        current.children.push(knight = Knight.new(move, current))
        queue.push(knight)
      end
      current = queue.shift
    end
    display_path(current, path, start)
    print_knight_moves(path)
  end
  # This method stores the path you took into an array.
  def display_path(current, path, start)
    until current.position == start
      path.push(current.position)
      current = current.parent
    end
    path.push(current.position)
  end
  # This method checks how many moves you made and prints the corresponding message.
  def print_knight_moves(path)
    if (path.size- 1) < 1
      puts "Your starting and finishing positions were the same. You didn't need to move."
    elsif (path.size - 1) == 1
      puts "You made it in #{path.size - 1} move! Here's your path:"
      path.reverse.each { |move| puts move.to_s }
    else
      puts "You made it in #{path.size - 1} moves! Here's your path:"
      path.reverse.each { |move| puts move.to_s }
    end
  end
end

bob = ChessBoard.new
bob.knight_moves([2, 3], [2, 4])
