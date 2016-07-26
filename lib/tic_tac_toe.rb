class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  # def user_input
  #   @user_input = gets.to_i
  # end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # def input_to_index(input)
  #   @index = input.to_i - 1
  # end

  def move(user_input, player = "X")
    input_index = user_input.to_i - 1
    @board[input_index] = player
  end

  def position_taken?(user_input)
    if @board[user_input] == "X" || @board[user_input] == "O"
      return true
    else
      return false
    end
  end

  def valid_move?(user_input)
    move = @board[user_input]
    if user_input >= 0 && user_input <= 8
      if move == "X" || move == "Y"
        return false
      else
        return true
      end
    end
  end

  def turn(board)
    puts "Please enter 1-9:"    #asks for user's input_to_index
    user_input = gets.strip          #gets input and assigns it to a variable
    index = user_input.to_i - 1 #converts the input to an index and assigns it to a variable "index"
    player = current_player(board)
    if valid_move?(board, index) == true
      move(board, index, player)
      display_board(board)
    else
      turn(board)
    end
  end

  def turn_count(board)
    counter = 0
    positions = 0   # Number of positions taken
    until counter == 9
      if board[counter] == "X" || board[counter] == "O"
        positions += 1
      end
      counter += 1
    end
    return positions
  end

  def current_player(board)
    turn_number = turn_count(board)
    if turn_number.even?
      return "X"
    else
      return "O"
    end
  end

  def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      index_1 = win_combination[0]
      index_2 = win_combination[1]
      index_3 = win_combination[2]
      if (board[index_1] == "X" && board[index_2] == "X" && board[index_3] == "X") || (board[index_1] == "O" && board[index_2] == "O" && board[index_3] == "O")
        return win_combination
      end
    end
    return false
  end

  def full?(board)
    if board.include?(" ")
      return false
    else
      return true
    end
  end

  def draw?(board)
    win = won?(board)
    full = full?(board)
    if win == false && full == true
      return true
    else
      return false
    end
  end

  def over?(board)
    win = won?(board)
    full = full?(board)
    draw = draw?(board)
    if full == true || draw == true || win != false
      return true
    else
      return false
    end
  end

  def winner(board)
    win_array = won?(board)
    if win_array != false
      win_index = win_array[0]
      return board[win_index]
    else
      return nil
    end
  end

  def play(board)
    until over?(board) == true
      turn(board)
    end
    if won?(board) != false
      winner = winner(board)
      puts "Congratulations #{winner}!"
    elsif draw?(board) == true
      puts "Cats Game!"
    end
  end

end
