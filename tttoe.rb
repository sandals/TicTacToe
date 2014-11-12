class E
	def to_s
		" "
	end
end

class X
	def to_s
		"\e[31mX\e[0m"
	end
end

class O
	def to_s
		"\e[32mO\e[0m"
	end
end

class Board
	def initialize
		@board = [
			[E,E,E],
			[E,E,E],
			[E,E,E]
		]	
	end

	def place_sigil type, x, y
		@board[y][x] = type
	end

	def print_board
		@board.each_with_index do |line, x_pos|
			print x_pos + 1, " "
			line.each_with_index do |position, y|
				print position.new, "|"
			end
			print "\n"
		end
		puts "+ 1 2 3"
	end

	def game_won?
		check_horizontal_win or check_vertical_win or check_diagonal_win
	end

	private

	def check_diagonal_win
		return false if @board[1][1] == E


		if (@board[0][0] == @board[1][1] and @board[1][1] == @board[2][2]) \
			or (@board[0][2] == @board[1][1] and @board[1][1] == @board[2][0])
			return true
		end

		false
	end

	def check_vertical_win 
		@board.each_with_index do |line, n|
			next if @board[0][n] == E or @board[1][n] == E or @board[2][n] == E

			if @board[0][n] == @board[1][n] and @board[1][0] == @board[2][n]
				return true
			end
		end

		false
	end

	def check_horizontal_win 
		@board.each do |line|
			next if line.include? E

			if line[0] == line[1] && line[1] == line[2]
				return true
			end
		end

		false
	end
end

class Game
	def initialize
		@board = Board.new
		@last_move = first_move
	end

	def run!
		loop do
			@board.print_board
			player_turn
			@last_move = current_player

			break if @board.game_won?
		end

		@board.print_board
		puts "#{@last_move} Won!"
	end

	private

	def first_move
		[X, O].sample
	end

	def current_player
		if @last_move == X
			O
		else
			X
		end
	end

	def player_turn
		puts "Your turn #{current_player}!"

		print "Enter Y: "
		y = gets.chomp.to_i
		print "Enter X: "
		x = gets.chomp.to_i

		@board.place_sigil(current_player, x - 1, y - 1)
	end
end

Game.new.run!
