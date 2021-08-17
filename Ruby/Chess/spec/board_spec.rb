require_relative "../lib/board"
require 'json'

describe Board do
    describe "#init" do
    end

    describe "verify_cell" do
        context "when the inputed cell is valid" do
            it "return true" do
                board = described_class.new
                expect(board.verify_cell(6,2)).to eq(true)
            end
        end

        context "when the inputed cell is invalid" do
            it "return false" do
                board = described_class.new
                expect(board.verify_cell(7,8)).to eq(false)
            end
        end
    end

    describe "#get_position" do
        context "when there is a chess at the inputed cell" do
            it "return the piece at the inputed cell" do
                board = described_class.new
                expect(board.get_position(0,0).to_s).to eq("rook 2 0 0")
            end
        end

        context "when there is not a chess at the inputed cell" do
            it "return nil" do
                board = described_class.new
                expect(board.get_position(2,4)).to be_nil
            end
        end

        context "when the inputed cell is invalid" do
            it "return nil" do
                board = described_class.new
                expect(board.get_position(-1,0)).to be_nil
            end
        end
    end

    describe "#path_blocked?" do
        context "when a chess can't move from source to destination" do
            it "return true" do
                board = described_class.new
                expect(board.path_blocked?([0,4],[2,4])).to eq(true)
            end
        end
        context "when a chess can move from source to destination" do
            it "return false" do
                board = described_class.new
                expect(board.path_blocked?([1,4],[2,4])).to eq(false)
            end
        end
    end

    describe "#move_chess" do 
        context "when the destination cell is empty" do
            it "move the chess to that cell and return true" do
                board = described_class.new
                expect(board.move_chess([1,0],[3,0])).to eq(true)
            end
        end
        context "when there is ally piece at the destination cell" do
            it "return false" do
                board = described_class.new
                expect(board.move_chess([0,0],[1,0])).to eq(false)
            end
        end
        context "when there is opponent's piece at the destination cell" do
            it "move the chess to that cell and return true" do
                board = described_class.new
                board.move_chess([1,3],[2,3])
                board.move_chess([0,2],[2,4])
                expect(board.move_chess([2,4],[6,0]).to_json).to eq(Piece.new("pawn",1,6,0).create_piece.to_json)
            end
        end
    end
end