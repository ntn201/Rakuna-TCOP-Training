require_relative "../lib/piece"

describe Piece do
    
    describe "#init" do
    #no thing to test
    end

    describe "#get_position" do
    #nothing to test
    end


    describe "#get_direction" do
        context "when it is a king" do
            subject(:piece_king) { described_class.new("king",1).create_piece }
            it "return [[0,1],[0,-1],[-1,0],[1,0],[-1,1],[1,1],[1,-1],[-1,-1]]" do
                expect(piece_king.get_direction).to eq([[0,1],[0,-1],[-1,0],[1,0],[-1,1],[1,1],[1,-1],[-1,-1]].to_set)
            end
        end

        context "when it is a queen" do
            subject(:piece_queen) { described_class.new("queen",1).create_piece }
            it "return [[0,1],[0,-1],[-1,0],[1,0],[-1,1],[1,1],[1,-1],[-1,-1]]" do
                expect(piece_queen.get_direction).to eq([[0,1],[0,-1],[-1,0],[1,0],[-1,1],[1,1],[1,-1],[-1,-1]].to_set)
            end
        end

        context "when it is a rook" do
            subject(:piece_rook) { described_class.new("rook",1).create_piece }
            it "return [[0,1],[0,-1],[-1,0],[1,0]]" do
                expect(piece_rook.get_direction).to eq([[0,1],[0,-1],[-1,0],[1,0]].to_set)
            end
        end

        context "when it is a knight" do
            subject(:piece_knight) { described_class.new("knight",1).create_piece }
            it "return [[2,-1],[2,-1],[-2,1],[-2,-1],[1,-2],[1,2],[-1,2],[-1,-2]]" do
                expect(piece_knight.get_direction).to eq([[2,-1],[2,1],[-2,1],[-2,-1],[1,-2],[1,2],[-1,2],[-1,-2]].to_set)
            end
        end

        context "when it is a bishop" do
            subject(:piece_bishop) { described_class.new("bishop",1).create_piece }
            it "return [[-1,1],[1,1],[1,-1],[-1,-1]]" do
                expect(piece_bishop.get_direction).to eq([[-1,1],[1,1],[1,-1],[-1,-1]].to_set)
            end
        end

        context "when it is a pawn and it belongs to team 2" do
            subject(:piece_pawn) { described_class.new("pawn",2).create_piece }
            it "return [[0,1],[1,-1],[1,1]]" do
                expect(piece_pawn.get_direction).to eq([[1,0],[1,-1],[1,1]].to_set)
            end
        end

        context "when it is a pawn and it belongs to team 1" do
            subject(:piece_pawn) { described_class.new("pawn",1).create_piece }
            it "return [[-1,0],[1,-1],[1,1]]" do
                expect(piece_pawn.get_direction).to eq([[-1,0],[-1,-1],[-1,1]].to_set)
            end
        end
    end

    describe "#get_distance" do
        context "when it is a king" do
            subject(:piece_king) { described_class.new("king",1).create_piece }
            it "return 1" do
                expect(piece_king.get_distance).to eq(1)
            end
        end

        context "when it is a queen" do
            subject(:piece_queen) { described_class.new("queen",1).create_piece }
            it "return 8" do
                expect(piece_queen.get_distance).to eq(8)
            end
        end

        context "when it is a rook" do
            subject(:piece_rook) { described_class.new("rook",1).create_piece }
            it "return 8" do
                expect(piece_rook.get_distance).to eq(8)
            end
        end

        context "when it is a knight" do
            subject(:piece_knight) { described_class.new("knight",1).create_piece }
            it "return 1" do
                expect(piece_knight.get_distance).to eq(1)
            end
        end

        context "when it is a bishop" do
            subject(:piece_bishop) { described_class.new("bishop",1).create_piece }
            it "return 8" do
                expect(piece_bishop.get_distance).to eq(8)
            end
        end

        context "when it is a pawn" do
            subject(:piece_pawn) { described_class.new("pawn",1).create_piece }
            it "return 2" do
                expect(piece_pawn.get_distance).to eq(2)
            end
        end
    end

    describe "#move_possible?" do
        context "when the move is valid" do
            it "return true" do
                piece_king = described_class.new("king",1,3,4).create_piece
                expect(piece_king.move_possible?(4,5)).to eq(true)
            end
            it "return true" do
                piece_knight = described_class.new("knight",1,2,2).create_piece
                expect(piece_knight.move_possible?(4,3)).to eq(true)
            end
        end
        context "when the move is invalid" do 
            it "return false" do
                piece_pawn = described_class.new("pawn",1,3,4).create_piece
                expect(piece_pawn.move_possible?(4,4)).to eq(false)
            end
            it "return false" do
                piece_knight = described_class.new("knight",1,2,2).create_piece
                expect(piece_knight.move_possible?(6,4)).to eq(false)
            end
        end
    end

    describe "#move_to" do
        context "When the destination is valid" do
            it "move a king of team 1 forward one row" do
                king = Piece.new("king",1,3,7)
                king.move_to(3,6)
                expect(king.get_position).to eq([3,6])
            end
            it "move a queen of team 2 forward 3 row" do
                queen = Piece.new("queen",2,0,4)
                queen.move_to(3,4)
                expect(queen.get_position).to eq([3,4])
            end
            it "move a bishop of team 1 forward one row to the left" do
                bishop = Piece.new("bishop",1,4,5)
                bishop.move_to(3,4)
                expect(bishop.get_position).to eq([3,4])
            end
            it "move a rook to the right most cell" do
                rook = Piece.new("rook",1,4,0)
                rook.move_to(4,7)
                expect(rook.get_position).to eq([4,7])
            end
            it "move a pawn of team 2 forward 2 row" do
                pawn = Piece.new("pawn",2,1,0)
                pawn.move_to(3,0)
                expect(pawn.get_position).to eq([3,0])
            end
            it "move a pawn of team 1 forward 1 row" do
                pawn = Piece.new("pawn",1,6,0)
                pawn.move_to(4,0)
                expect(pawn.get_position).to eq([4,0])
            end
        end
    end
end