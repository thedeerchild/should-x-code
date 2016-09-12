#!/usr/bin/env ruby

require 'dotenv'

require "./lib/authentic.rb"
require './lib/tweet_sender.rb'

Dotenv.load if ENV['TWITTER_CONSUMER_KEY'].nil?

TweetSender.new.tweet Authentic.new.get_job