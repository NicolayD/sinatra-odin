require 'sinatra'
require_relative 'lib/caesar_cipher'
require_relative 'lib/hangman/hangman'

enable :sessions
set :static_cache_control, [:public, max_age: 600]

get '/' do
	session[:game] = Hangman.new
	session[:incorrect] = session[:game].incorrect
	session[:correct] = session[:game].correct
	session[:answer] = session[:game].answer
	session[:hidden_answer] = session[:game].hidden_answer
	session[:guess] = session[:game].guess
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

get '/hangman' do
	letter = params['letter'] if params['letter'] =~ /^([a-z]|[A-Z])$/
	if letter && session[:game].turns > 0 && session[:guess].join != session[:answer]
		if session[:correct].include?(letter.downcase) || session[:incorrect].include?(letter.downcase)
			message = "Choose a new letter"
		else
			session[:game].check_guess letter
			message = session[:game].message
		end
	else
		message = "Choose one Latin letter"
	end

	incorrect_letters = session[:incorrect].join(" ")
	
	erb :hangman, locals: { answer: session[:answer], guess: session[:guess].join, turns: session[:game].turns, 
		hidden_answer: session[:hidden_answer], message: message, incorrect: incorrect_letters }
end