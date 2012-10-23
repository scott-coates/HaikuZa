class Haiku
	include Mongoid::Document
	include Mongoid::Timestamps
	 field :screen_name, type: String
	 field :tweet_id, type: Integer
	 field :content, type: String
	 field :retweet_points, type: Integer
	 
	 belongs_to :user

	 attr_accessible :screen_name, :tweet_id, :content, :retweet_points

	 index({ tweet_id: -1 }, { background: true })

	 def increase_points(point)
 		if point.point_type == :retweet
 			self.retweet_points ||= 0 #TODO: why do I need to call self and not @?
 			self.retweet_points += point.value 
 		end	
	 end
end