require 'rubygems'
require 'bundler'
Bundler.require

require './controller'

run Sinatra::Application
