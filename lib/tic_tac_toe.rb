class TicTacToe

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8],   
        [0,3,6], [1,4,7], [2,5,8], 
        [0,4,8], [2,4,6] 
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    def turn_count  
        @board.count { |xo| xo != " "}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number (1-9):" #asks for input
        #user_input = gets.strip #receives AKA 'gets' user input
        index = input_to_index(gets.strip)  #turn input into index
        if valid_move?(index)  #valid? make move of current_player & display board
            move(index, current_player)
            display_board
        else   #not valid? ask for new move until valid move received
            turn
        end
    end

    def won?
       WIN_COMBINATIONS.any? do |win_combo|
        if position_taken?(win_combo[0]) && @board[win_combo[0]] == @board[win_combo[1]] && @board[win_combo[1]] == @board[win_combo[2]]
            #checks for a winning combo withing constant AND within the "current" board
        return win_combo  #return an array containing the winning combination indexes if there is a win.
       end
       end
    end

    def full?
        @board.all?{|square| square != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end


end 