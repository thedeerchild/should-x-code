require 'rest-client'

class Authentic
  def initialize redis_client
    @redis = redis_client
  end

  def get_job
    resp = RestClient.get "https://authenticjobs.com/api/?api_key=#{ENV['AUTHENTIC_JOBS_API_KEY']}&method=aj.jobs.search&perpage=100&format=json"
    listings = JSON.parse(resp.body)['listings']['listing']
    listing = listings.shuffle.detect { |x| !already_posted? x }

    @redis.set(redis_key(listing['id']), true, ex: (60 * 60 * 24 * 30)) # Don't show again for 30 days

    return {
      id: listing['id'],
      title: listing['title'],
      employer: listing.fetch('company', {})['name'] # Some companies are "confidential" and don't return a name
    }
  end

private

  def redis_key listing_id
    "authentic:job_id:#{listing_id}"
  end

  def already_posted? listing
    @redis.exists(redis_key(listing['id']))
  end
end