# Interactive command line blackjack game


def calculate_total(cards) 
  # [['H', '3'], ['S', 'Q'], ... ]
  arr = cards.map {|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  # correct for aces
  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  total
end

puts "Welcome to Blackjack!"
puts ""

suits = ['h', 'd', 's', 'c']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

while true

  deck = suits.product(cards)
  deck.shuffle!

  # Deal Cards

  mycards = []
  dealercards = []
  mytotal = 0

  mycards << deck.pop
  dealercards << deck.pop
  mycards << deck.pop
  dealercards << deck.pop

  dealertotal = calculate_total(dealercards)
  mytotal = calculate_total(mycards)

  # Show Cards
  while mytotal < 21
    puts "Dealer is showing \"#{dealercards[1].join}\""
    puts "You have: #{mycards.map{|c| c.join}}, for a total of: #{mytotal}"
    puts ""
    puts "What would you like to do? 1) hit 2) stay"
    hit_or_stay = gets.chomp

    if hit_or_stay == "1"
      mycards << deck.pop
      mytotal = calculate_total(mycards)
      puts ""
      print "Player hits... "
      sleep 1
      puts "\"#{mycards[-1].join}\""
      sleep 1
      puts ""
      puts "You've got 21!" if mytotal == 21
    else
      break
    end
  end

  if mytotal > 21
    puts ""
    puts "BUST!"
    puts ""
    puts "You have: #{mycards.map{|c| c.join}}, for a total of: #{mytotal}"
    puts "Dealer had: #{dealercards.map{|c| c.join}}, for a total of: #{dealertotal}"
  else
    while dealertotal < 17
      puts ""
      print "Dealer hits... "
      dealercards << deck.pop
      sleep 1
      puts "\"#{dealercards[-1].join}\""
      sleep 1
      dealertotal = calculate_total(dealercards)
      puts ""
      puts "Dealer BUSTS!" if dealertotal > 21
      puts "Dealer has: #{dealercards.map{|c| c.join}}, for a total of: #{dealertotal}"
    end

    puts""
    puts "You have: #{mycards.map{|c| c.join}}, for a total of: #{mytotal}"
    puts "Dealer has: #{dealercards.map{|c| c.join}}, for a total of: #{dealertotal}"
    
    if mytotal == dealertotal
      puts ""
      puts "You tie!"
    elsif mytotal > dealertotal
      puts ""
      puts "You win!"
    elsif mytotal < dealertotal && dealertotal < 22
      puts ""
      puts "You lose!"
    end
  end

  puts "Q to quit. ENTER to play again."
  resp = gets.chomp
  if resp.upcase == "Q"
    puts ""
    puts "Goodbye."
    break
  end
end
