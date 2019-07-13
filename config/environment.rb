require 'bundler/setup'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'
Bundler.require(:default, :development)

module Cli_Project
  class Error < StandardError; end
    #Your code goes here...
  end
  
require_relative '../lib/cli'
require_relative '../lib/movie'
require_relative '../lib/scraper'