def stock_picker(prices)
  hashola = []
  result = 0
  winner = {}
  prices.each_index do |dex|
    hashola.push({
                   num: prices[dex],
                   pos: dex,
                   diff: 0,
                   diff_pos: 0
                 })

    val = dex
    until val == prices.length
      if (prices[dex] - prices[val]) < hashola[dex][:diff]
        hashola[dex][:diff] = prices[dex] - prices[val]
        hashola[dex][:diff_pos] = val
      end
      val += 1
    end
  end

  hashola.each_index do |index|
    if hashola[index][:diff] <= result
      result = hashola[index][:diff]
      winner = hashola[index]
    end
  end

  puts "buy at position #{winner[:pos]} and sell at #{winner[:diff_pos]}"
end
stock_picker([17, 3, 6, 9, 15, 8, 6, 11, 10, 3, 1])
