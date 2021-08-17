class Piece
    def initialize(type,team,x=nil,y=nil,direction=nil,distance=nil)
        @type = type
        @team = team
        @direction = direction ? direction : get_direction
        @distance = distance ? distance : get_distance
        @x = x
        @y = y
    end

    def create_piece
        return case @type
            when "king" then King.new(@type,@team,@x,@y,@direction,@distance)
            when "queen" then Queen.new(@type,@team,@x,@y,@direction,@distance)
            when "rook" then Rook.new(@type,@team,@x,@y,@direction,@distance)
            when "knight" then Knight.new(@type,@team,@x,@y,@direction,@distance)
            when "bishop" then Bishop.new(@type,@team,@x,@y,@direction,@distance)
            when "pawn" then Pawn.new(@type,@team,@x,@y,@direction,@distance)
        end
    end

    def get_symbol
        return case @type
            when "king" then @team == 1 ? "\u2654".encode("utf-8") : "\u265A".encode("utf-8")
            when "queen" then @team == 1 ? "\u2655".encode("utf-8") : "\u265B".encode("utf-8")
            when "rook" then @team == 1 ? "\u2656".encode("utf-8") : "\u265C".encode("utf-8")
            when "knight" then @team == 1 ? "\u2658".encode("utf-8") : "\u265E".encode("utf-8")
            when "bishop" then @team == 1 ? "\u2657".encode("utf-8") : "\u265D".encode("utf-8")
            when "pawn" then @team == 1 ? "\u2659".encode("utf-8") : "\u265F".encode("utf-8")
        end
    end

    def get_position
        return @x, @y
    end

    def get_direction
        return  case @type
            when "king" then [[0,1],[0,-1],[-1,0],[1,0],[-1,1],[1,1],[1,-1],[-1,-1]].to_set
            when "queen" then [[0,1],[0,-1],[-1,0],[1,0],[-1,1],[1,1],[1,-1],[-1,-1]].to_set
            when "rook" then [[0,1],[0,-1],[-1,0],[1,0]].to_set
            when "knight" then [[2,-1],[2,1],[-2,1],[-2,-1],[1,-2],[1,2],[-1,2],[-1,-2]].to_set
            when "bishop" then [[-1,1],[1,1],[1,-1],[-1,-1]].to_set
            when "pawn" then @team == 2 ? [[1,0],[1,-1],[1,1]].to_set : [[-1,0],[-1,-1],[-1,1]].to_set
        end
    end

    def get_distance
        return case @type
            when "king" then 1
            when "queen" then 8
            when "rook" then 8
            when "knight" then 1
            when "bishop" then 8
            when "pawn" then 2
        end
    end

    def verify_destination(row,col)
        if row >= 0 and row <= 7
            if col >= 0 and col <= 7
                return true
            end
        end
        return false
    end

    def move_possible?(row,col)
        dir = extract_direction(row,col)
        dist = [(row-@x).abs, (col-@y).abs].max
        if @direction.member?(dir) and dist <= @distance
            return true
        end
        return false
    end

    def move_to(row,col)
        if verify_destination(row,col) and move_possible?(row,col)
            @x = row
            @y = col
        end
    end

    def extract_direction(row,col)
        diff = row-@x, col-@y
        diff[0] != 0 ? diff[0] /= diff[0].abs : diff[0] = 0
        diff[1] != 0 ? diff[1] /= diff[1].abs : diff[1] = 0
        return diff[0], diff[1]
    end

    def to_s
        return "#{@type} #{@team} #{@x} #{@y}"
    end

    def get_team
        return @team
    end

    def get_type
        return @type
    end
end


class King < Piece
end

class Queen < Piece
end

class Rook < Piece
end

class Knight < Piece
    def extract_direction(row,col)
        return row-@x, col-@y
    end

    def move_possible?(row,col)
        dir = extract_direction(row,col)
        if @direction.member?(dir)
            return true
        end
        return false
    end
end

class Bishop < Piece
end

class Pawn < Piece
end