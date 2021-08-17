class Board
    def initialize
        @board = Array.new(8) { Array.new(8) { nil } }
        init_board
    end

    def init_board
        chess_pos = [["rook","knight","bishop","king","queen","bishop","knight","rook"],
                     ["pawn","pawn","pawn","pawn","pawn","pawn","pawn","pawn"]]
        for i in (0..1)
            for j in (0..7)
                @board[i][j] = Piece.new(chess_pos[i][j],2,i,j).create_piece
            end
        end
        
        for i in (0..1)
            for j in (0..7)
                @board[7-i][j] = Piece.new(chess_pos[i][j],1,7-i,j).create_piece
            end
        end
    end

    def print_board
        for row in @board
            for col in row
                if col 
                    print "#{col.get_symbol} "
                else
                    print "- "
                end
            end
            puts
        end
        puts
    end

    def verify_cell(row,col)
        if row >= 0 and row <= 7
            if col >= 0 and col <= 7
                return true
            end
        end
        return false
    end

    def get_position(row,col)
        if !verify_cell(row,col)
            return nil
        end
        piece = @board[row][col]
        return piece ? piece : nil
    end

    def path_blocked?(src,dest)
        x, y = src[0],src[1]
        row, col = dest[0], dest[1]
        piece = get_position(x,y)
        if !piece
            return nil
        end
        direction = piece.extract_direction(row,col)
        while [x,y] != dest do
            x += direction[0]
            y += direction[1]
            cell = get_position(x,y)
            if cell
                if cell.get_team == piece.get_team
                    return true
                end
            end
        end
        return false
    end

    def move_chess(src,dest)
        piece = get_position(src[0],src[1])
        if !piece
            return false
        end
        if path_blocked?(src,dest)
            return false
        end
        if !piece.move_possible?(dest[0],dest[1])
            return false
        end
        captured = @board[dest[0]][dest[1]]
        @board[dest[0]][dest[1]] = piece
        @board[src[0]][src[1]] = nil
        piece.move_to(dest[0],dest[1])
        if captured
            return captured
        end
        return true
    end
end
