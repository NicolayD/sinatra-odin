require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/caesar_cipher'
require_relative 'lib/hangman/hangman'

enable :sessions

class Hangman
	attr_accessor :answer, :hidden_answer, :turns, :guess, :incorrect, :correct, :message

	def initialize
		dictionary = File.read("lib/hangman/5desk.txt").split
		@answer = dictionary[rand(dictionary.length)] # while @answer.length < 5 || @answer.length > 12
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
			if @guess.join == @answer
				@message = "You won!"
			end
		else
			@turns -= 1
			@incorrect << letter
		end
		@message = "#{@turns} left."

		if @turns == 0
			@message = "You lose! The answer is #{@answer}."
		end
	end
end

get '/' do
	session[:game] = Hangman.new
	session[:incorrect] = session[:game].incorrect
	session[:correct] = session[:game].correct
	erb :index
end

get '/caesar' do
	if params['phrase'] && params['factor']
		phrase = params['phrase']
		factor = params['factor']
		output = caesar_cipher(phrase,factor)
	end
	erb :caesar, locals: { output: output }
end

get '/hangman' do 	# Implement new game option, show correct answer at the end. Maybe use sessions?

	if params['letter']
		letter = params['letter']
		if session[:correct].include?(letter) || session[:incorrect].include?(letter) || letter !~ /^[a-z]+$/
			message = "Choose a new letter"
		else
			session[:game].check_guess letter
			message = session[:game].message
		end
	end

	if session[:game].turns < 0
		message = "You lost. You can't continue."
	end
	
	incorrect_letters = session[:incorrect].join(" ")
	
	erb :hangman, locals: { turns: session[:game].turns, hidden_answer: session[:game].hidden_answer, message: message, incorrect: incorrect_letters }
end