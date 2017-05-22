require 'csv'

=begin
def read_saved_games
	CSV.read "saves.csv", headers: true, header_converters: :symbol
end

def save_game(i, guess, answer, correct_guesses)
	puts "Save game? (y/n)"
	save_or_not = gets.chomp
	until save_or_not =~ /y|n/
		puts "Please choose 'y' or 'n'."
		save_or_not = gets.chomp
	end

	if save_or_not == 'y'
		number_of_saves = 0
		saves = read_saved_games
		saves.each do |row|
			number_of_saves +=1
		end
		CSV.open("saves.csv", "a+") do |saves|
			puts
			saves << ["#{number_of_saves + 1}", "#{guess}", "#{i}", "#{answer}", correct_guesses]
		end
	end
end
=end

def hangman(i=12,guess="",answer="", correct_guesses=[])

=begin
	answer_array = answer.split(//)
	incorrect_letters = []
	i.times do
	puts guess
		letter = gets.chomp
		until letter =~ /[a-z]/ && letter.length == 1 && !incorrect_letters.include?(letter) && !correct_guesses.include?(letter)
			puts "Please choose only one new lowercase letter."
			letter = gets.chomp
		end

		if answer_array.include? letter || answer_array.include?(letter.upcase)						
			answer_array.each_with_index do |let, index| 															
				if letter == let || letter.upcase == let
					guess[index] = let
					correct_guesses << letter if !correct_guesses.include?(letter)
				end
			end
			if guess == answer
				puts "You won!"
				puts "The answer is #{answer}."
				break
			end

		else
			incorrect_letters << letter
		end

		puts guess
		puts
		puts "Incorrect letters: "
		puts incorrect_letters.join(" ")

		i -= 1
		if i == 0
			puts "You lost."
			puts "The answer is: #{answer}."
			break
		end
=end

#		puts "#{i} turns left."

#		save_game(i, guess, answer, correct_guesses)
#	end
end 

=begin
puts "Welcome to Hangman!"
puts
puts %{1. New Game
2. Load Game
3. Exit}
choice = gets.chomp
until ["1", "2", "3"].include? choice
	puts "Please choose 1, 2 or 3."
	choice = gets.chomp
end

if choice == 3.to_s
	exit
elsif choice == 1.to_s
	puts "The computer will now choose a random word."
	puts "You have to guess its letters in 12 turns."

	play_game

elsif choice == 2.to_s
	puts "Which game do you want to load? Pick a number."
	saved_game_index = []
	saves = read_saved_games
	saves.each do |row|
		puts "#{row[:number]}. #{row[:guess]} #{row[:turns]} turns left"
		saved_game_index << "#{row[:number]}"
	end

	number_choice = gets.chomp
	until saved_game_index.include? number_choice
		puts "Incorrect number. Please select a saved game."
		number_choice = gets.chomp
	end

	guess = ""
	i = 0
	answer = ""
	incorrect_letters = []
	correct_guesses = []
	
	saves = read_saved_games
	saves.each do |row|
		if row[:number] == number_choice
			guess = row[:guess]
			i = row[:turns].to_i
			answer = row[:answer]
			correct_guesses = row[:correct_letters]
		end
	end

	play_game(i,guess,answer,correct_guesses)
end
=end