require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative "./cli_project/version"

module Cli_Project
  class Error < StandardError; end
    #Your code goes here...
  end
  
require_relative './cli'
require_relative './scraper'