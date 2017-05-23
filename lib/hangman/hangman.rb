class Hangman
	attr_accessor :answer, :hidden_answer, :turns, :guess, :incorrect, :correct, :message

	def initialize
		dictionary = File.read("lib/hangman/5desk.txt").split
		@answer = dictionary[rand(dictionary.length)] 
		while @answer.length < 5 || @answer.length > 12
			@answer = dictionary[rand(dictionary.length)]
		end
		@hidden_answer = []
		@answer.length.times { @hidden_answer << "_" }
		@turns = 12
		@guess = []
		@incorrect = []
		@correct = []
		@message = ''
	end

	def check_guess letter
		answer_array = @answer.split(//)
		if answer_array.include? letter || answer_array.include?(letter.upcase)			
			answer_array.each_with_index do |let, index|		
				if letter == let || letter.upcase == let
					@guess[index] = let
					@correct << letter if !@correct.include?(letter)
					@hidden_answer[index] = let
				end
			end
		else
			@turns -= 1
			@incorrect << letter
		end
		@message = "#{@turns} turns left."
		@message = "You lose! The answer is #{@answer}." if @turns == 0
		@message = "You won!" if @guess.join == @answer
	end
end