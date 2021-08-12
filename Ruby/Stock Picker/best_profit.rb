def best_profit(prices)
    profit = 0
    result = [0,0]
    for day_buy in (0...prices.length).to_a
        for day_sell in (day_buy+1...prices.length).to_a
            if prices[day_sell] - prices[day_buy] > profit
                profit = prices[day_sell] - prices[day_buy]
                result = [day_buy, day_sell]
            end
        end
    end
    return result
end

puts best_profit([17,3,6,9,15,8,6,1,10])