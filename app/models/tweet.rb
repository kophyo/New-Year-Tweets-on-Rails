class Tweet < ActiveRecord::Base
  
  #A method to grab latest tweets from Twitter
  def self.get_latest_new_year_resolution_tweets
    
    #create a Twitter Search object
    search = Twitter::Search.new
    
    #grab recent 100 tweets which contain 'new year resolution' words, and loop each of them
    search.containing("new year resolution").result_type("recent").per_page(100).fetch.each do |tweet_results|
      
      #parsing the string 'created_at' to DateTime object
      twitter_created_at = DateTime.parse(tweet_results.created_at)
      
      #making sure we are not saving exact same tweet from a person again 
      unless Tweet.exists?(['twitter_created_at = ? AND from_user_id_str = ?', DateTime.parse(tweet_results.created_at), tweet_results.from_user_id_str])
      
        #finally creating the tweet record
        Tweet.create!({
            :from_user => tweet_results.from_user,
            :from_user_id_str => tweet_results.from_user_id_str,
            :profile_image_url => tweet_results.profile_image_url,
            :text => tweet_results.text,
            :twitter_created_at => twitter_created_at
        })
      end
    end
  end
end
