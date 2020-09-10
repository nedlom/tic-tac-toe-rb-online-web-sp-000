WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select{|x| x == "X" || x == "O"}.length
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all?{|index| position_taken?(board, index) && board[index] == "X"}
      return combo
    end
    if combo.all?{|index| position_taken?(board, index) && board[index] == "O"}
      return combo
    end
  end
  false
end

def full?(board)
  board.all?{|index| index == "X" || index == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  board[won?(board)[0]] if won?(board)
end

def play(board)
  while !over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  
  if draw?(board)
    puts "Cat's Game!"
  end
end
