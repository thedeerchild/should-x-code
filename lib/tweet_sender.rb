class TweetSender
  def initialize twitter_client
    @twitter = twitter_client
  end

  def tweet job_data
    send_tweet(format_tweet(job_data))
  end

  def format_tweet job_data
    "#{job_line(job_data)}#{cta_line}"
  end

private

  def send_tweet message
    @twitter.update message
  end

  def job_line job_data
    def self.indef_article word
      return word if word[0] == '@'
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

  def cta_line
    lines = [
      ' Reply with your answer.',
      ' Fav for yes; RT for no.',
      ' RT for yes; fav for no.',
      '', '', '', '', '', '' # 1 in 3 chance of CTA line
    ]

    lines.sample
  end
end
