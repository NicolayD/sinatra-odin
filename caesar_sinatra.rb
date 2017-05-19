require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/caesar_cipher'

get '/' do
	erb :index
end