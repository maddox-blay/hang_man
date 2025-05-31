require 'yaml'

dictionary = File.readlines("google-10000-english-no-swears.txt", chomp: true)
pick_pool = dictionary.select { |word| word.length >= 5 && word.length <= 12  }

puts "Do you want to open save file: y/n"
choice = gets.chomp
if choice == "y"
  puts "1. save 1"
  puts "2. save 2"
  puts "3. save 3"
  print "1/2/3: "
  num = gets.chomp

  case num
  when '1'
    save = YAML.load_file("save1.yml")
  when '2'
    save = YAML.load_file("save2.yml")
  when '3'
    save = YAML.load_file("save3.yml")
  end

  guess = save["current"]
  pick = save["word"]
  valid_guesses = save["valid"]
  invalid_guesses = save["invalid"]
  mistakes = save["mistake"]

elsif choice == "n"
  puts "start"
  pick = pick_pool.sample
  guess = []
  valid_guesses = ("a".."z").to_a
  invalid_guesses = []
  mistakes = 5
  pick.length.times do
    guess.push("_")
  end
else 
  puts "invalid"
end

puts guess.join(" ")


while true

  details = {
    "word" => pick,
    "current" => guess, 
    "mistake" => mistakes, 
    "valid" => valid_guesses, 
    "invalid" => invalid_guesses
  }

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

  puts "save:y/n"
  option = gets.chomp

  if option == 'y'
    puts "1. save 1"
    puts "2. save 2"
    puts "3. save 3"
    print "1/2/3: "
    num = gets.chomp

    case num
      when '1'
        File.open("save1.yml", "w") do |file|
          file.write(details.to_yaml)
        end
        puts "saved to save 1"
      when '2'
        File.open("save2.yml", "w") do |file|
          file.write(details.to_yaml)
        end
        puts "saved to save 2"
      when '3'
        File.open("save2.yml", "w") do |file|
          file.write(details.to_yaml)
        end
        puts "saved to save 3"
    end
  end

end
