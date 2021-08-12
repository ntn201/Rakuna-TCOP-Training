def buble_sort(arr)
    (arr.length-1).times do |i| 
        for j in (0...arr.length-i-1).to_a
            if arr[j] > arr[j+1]
                temp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = temp
            end
        end
    end
    return arr
end

print buble_sort([5,1,314,36,54,1,313,53,743,6])
puts