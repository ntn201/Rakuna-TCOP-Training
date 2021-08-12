def substrings (string, dict)
    return dict.reduce(Hash.new(0)) do |result, word|
        if string.downcase.include?(word.downcase)
            result[word] += 1
        end
        result
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
