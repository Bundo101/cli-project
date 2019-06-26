require 'bundler/setup'
Bundler.require(:default, :development)

module Cli_Project
  class Error < StandardError; end
    #Your code goes here...
  end
  
require_relative '../lib/cli'
require_relative '../lib/movie'
require_relative '../lib/scraper'