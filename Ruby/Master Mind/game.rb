class MasterMind
    def initialize()
        @code = Array.new(4) {rand(1..6)}
        @clues = []
        @turn = 1
    end

    def is_guess_valid(guess)
        if guess.length != 4
            return false
        end
        return guess.all? {|digit| digit > 0 and digit < 7}
    end

    def generate_clues(guess)
        @clues = []
        check = [0,0,0,0]
        for i in (0..3)
            for j in (0..3)
                if guess[i] == @code[i] and check[i] == 0
                    @clues.push("x")
                    check[i] = 1
                    break
                end
                if guess[i] == @code[j] and check[j] == 0
                    @clues.push("o")
                    check[j] = 1
                    break
                end
            end
        end
    end 

    def turn()
        puts "Turn #{@turn}: What's do you think the code is?"
        guess = gets.gsub("\n","").split("").map {|digit| digit.to_i}
        while !is_guess_valid(guess) do
            puts "The code you've entered is invalid, try another code!"
            guess = gets.gsub("\n","").split("").map {|digit| digit.to_i}
        end
        if guess == @clues
            puts "Congrats! You got the secret code!"
            return true
        else
            generate_clues(guess)
            puts "Clues: #{@clues.sort.inspect}, x for a right digit at right slot, o for a right digit at wrong slot"
        end
    end

    def start()
        while @turn <= 12 do
            if turn
                return true
            end
            @turn += 1
        end
        puts "You run out of turn!"
    end
end


game = MasterMind.new
game.start
