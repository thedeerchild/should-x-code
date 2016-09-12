class Followers
  def initialize twitter_client, redis_client
    @twitter = twitter_client
    @redis = redis_client
  end

  def get_follower 
    follower = @twitter.followers.collect.detect { |x| !already_posted? x }

    return nil if follower.nil?

    @redis.set(redis_key(follower.id), true)

    return {
      id: follower.id,
      title: "@#{follower.screen_name}"
    }
  end

private

  def redis_key user_id
    "twitter:follower_id:#{user_id}"
  end

  def already_posted? user
    @redis.exists(redis_key(user.id))
  end
end