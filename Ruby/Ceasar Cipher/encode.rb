def ceasar_cipher(message, shift)
    return message.split("").reduce("") do |encoded, char|
        if (char.ord > 64 and char.ord < 91 - shift) then
            encoded += (char.ord + shift).chr
        elsif  (char.ord > 91 - shift and char.ord < 91) 
            encoded += (64 + (char.ord + shift - 90)).chr
        elsif (char.ord > 96 and char.ord < 123 - shift) 
            encoded += (char.ord + shift).chr
        elsif (char.ord > 122 - shift and char.ord < 123) 
            encoded += (96 + (char.ord + shift - 122)).chr
        else
            encoded += char
        end
        encoded
    end
end

puts ceasar_cipher("What a string!", 5)
