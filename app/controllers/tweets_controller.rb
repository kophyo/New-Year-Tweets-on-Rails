class TweetsController < ApplicationController
  def index
    #Get the tweets (records) from the model Ordered by 'twitter_created_at' descending
    @tweets = Tweet.order("twitter_created_at desc")    
  end

end
