#!/usr/bin/env ruby

require 'dotenv'
require 'twitter'
require 'redis'

require "./lib/authentic.rb"
require './lib/followers.rb'
require './lib/tweet_sender.rb'

Dotenv.load if ENV['TWITTER_CONSUMER_KEY'].nil?

twitter_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
end

redis_client = Redis.new(url: ENV['REDIS_URL'])

if Random.rand(100) < 5
  follower = Followers.new(twitter_client, redis_client).get_follower
  TweetSender.new(twitter_client).tweet follower unless follower.nil?
else
  TweetSender.new(twitter_client).tweet Authentic.new(redis_client).get_job
end
