require 'twitter'

class TweetSender
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

  def tweet job_data
    send_tweet(format_tweet(job_data))
  end

private

  def send_tweet message
    @client.update message
  end

  def format_tweet job_data
    def self.indef_article word
      # No "U" because the most common are UX and UI
      article = (%w(a e i o).include? word[0].downcase) ? 'an' : 'a'
      "#{article} #{word}"
    end

    # Remove employer from job title in "title @ emp" or "title at emp" type listings
    title = job_data[:title].gsub(/\s@.*/, '').gsub(/\sat.*/, '')

    unless job_data[:employer].nil?
      "Should #{indef_article(title)} at #{job_data[:employer]} code?"
    else
      "Should #{indef_article(title)} code?"
    end
  end
end
