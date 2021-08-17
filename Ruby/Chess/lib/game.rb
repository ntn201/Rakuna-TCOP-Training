require_relative "./board"

class Game
    def initialize
        @turn = 0
        @turn_player = 1
        @board = Board.new
        @team = {"1" => "white", "2" => "black"}
        @game_over = false
    end

    def verify_cell_input(cell)
        begin
            cell = cell.map {|num| Integer(num)}
            return (cell[0] >= 0 and cell[0] <=7 and cell[1] >= 0 and cell[1] <= 7)
        rescue 
            return false
        end
    end

    def cell_input
        print "Enter a cell: "
        cell = gets.chomp.split(" ").to_a
        while !verify_cell_input(cell) do
            print "Invalid cell, try again: "
            cell = gets.chomp.split(" ").to_a
        end
        return cell.map {|num| num.to_i}
    end

    def choose_piece
        row, col = cell_input
        piece = @board.get_position(row,col)
        until piece and piece.get_team == @turn_player do
            puts piece
            puts "There is no ally chess at that cell!"
            row, col = cell_input
            piece = @board.get_position(row,col)
        end
        return piece
    end

    def move_piece(piece)
        puts "Move chess to?"
        cell = cell_input
        until captured = @board.move_chess(piece.get_position,cell) do
            puts "Invalid cell!"
            cell = cell_input
        end
        return captured
    end
    
    def change_player
        @turn_player = @turn_player == 1 ? 2 : 1
    end

    def turn
        @board.print_board
        puts "It's #{@team[@turn_player.to_s]}'s turn, choose a chess to move"
        piece = choose_piece
        if move_piece(piece).class == King
            @game_over = true
        end
        change_player
    end

    def play
        while !@game_over do
            turn
        end
        puts "#{@team[@turn_player.to_s]} wins!"
    end

end