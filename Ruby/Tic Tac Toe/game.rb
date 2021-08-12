class TicTacToe
    def initialize()
        @board = [['-','-','-'],['-','-','-'],['-','-','-']]
        @players = [nil,nil]
        @turn_player = nil
        @turn = 1
    end

    def reset()
        @board = [['-','-','-'],['-','-','-'],['-','-','-']]
        @turn_player = nil
        @turn = 1
    end

    def add_player(player)
        if @players[0] == nil
            @players[0] = player
        else
            if @players[1] == nil
                @players[1] = player
            end
        end
    end

    def print_board()
        puts @board.map { |x| x.join(' ') }
    end

    def place(row,col,char)
        if row > -1 and row < 3
            if col > -1 and col < 3
                if @board[row][col] == "-"
                    @board[row][col] = char
                    return true
                end
            end
        end
        return false
    end

    def is_over()
        if @board[0][0] == @board[1][1] and @board[1][1] == @board[2][2] and @board[0][0] != "-"
            return true
        end
        for i in (0..2)
            for j in (0..2)
                if @board[0][j] == @board[1][j] and @board[1][j] == @board[2][j] and @board[0][j] != "-"
                    return true
                end
                if @board[i][0] == @board[i][1] and @board[i][1] == @board[i][2] and @board[i][0] != "-"
                    return true
                end
            end
        end
        return false
    end

    def change_player()
        if @turn_player == @players[0]
            @turn_player = @players[1]
        else
            @turn_player = @players[0]
        end
    end

    def turn()
        cell = gets.split(" ").map {|num| num.to_i}
        while !place(cell[0], cell[1], @turn_player.get_character) do
            puts "Invalid cell, try again!"
            cell = gets.split(" ").map {|num| num.to_i}
        end
        if is_over
            puts "Game is over, #{@turn_player.get_name} wins"
            @turn_player.increase_point
        end
        change_player
        @turn += 1
    end

    def start()
        @turn_player = @players[0]
        while !is_over do
            print_board
            puts "Turn #{@turn.to_s}\nIt's #{@turn_player.get_name}'s turn, choose a cell"
            turn
        end
        reset
    end
end


class Player
    def initialize(name, char)
        @name = name.to_s
        @character = char.to_s
        @point = 0
    end

    def get_name()
        return @name
    end
    
    def get_character()
        return @character
    end

    def get_point()
        return @point
    end
    
    def increase_point()
        point += 1
    end
end

game = TicTacToe.new
bob = Player.new("Bob","x")
peter = Player.new("Peter","o")
game.add_player(bob)
game.add_player(peter)
game.start