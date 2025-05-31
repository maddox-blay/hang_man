dictionary = File.readlines("google-10000-english-no-swears.txt", chomp: true)
pick_pool = dictionary.select { |word| word.length >= 5 && word.length <= 12  }
pick = pick_pool.sample
guess = []
valid_guesses = ("a".."z").to_a
invalid_guesses = []
mistakes = 5

pick.length.times do
  guess.push("_")
end
puts guess.join(" ")

while true
  print "Type in your guess: "
  user_guess = gets.chomp
  if valid_guesses.include?(user_guess) && user_guess.length == 1
    if pick.include?(user_guess) 
      indexes = pick.chars.each_with_index.select { |char, index| char == user_guess }.map { |ch, i| i  }
      puts indexes
      for index in indexes
        guess[index] = user_guess
      end 
    else
      puts "wrong"
      mistakes -= 1
    end
  elsif invalid_guesses.include?(user_guess) && user_guess.length == 1
      puts "you already guessed this"
  else
      puts "invalid guess"
  end

  invalid_guesses << valid_guesses.delete(user_guess)

  if mistakes == 0
    puts "You Lost"
    break
  elsif guess.join == pick
    puts pick
    puts "You Won!!"
    break
  end
  puts guess.join(" ")
  puts "mistakes left: #{mistakes}"
end