require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/caesar_cipher'

get '/' do
	if params['phrase'] && params['factor']
		phrase = params['phrase']
		factor = params['factor']
		output = caesar_cipher(phrase,factor)
	end
	erb :index, locals: { output: output }
end