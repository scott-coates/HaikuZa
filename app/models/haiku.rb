class Haiku
	include Mongoid::Document
	include Mongoid::Timestamps
	 field :screen_name, type: String
	 field :tweet_id, type: Integer
	 field :content, type: String
	 field :likes, type: Integer
	 
	 embedded_in :user

	 attr_accessible :screen_name, :tweet_id, :content, :likes

	 def increase_points(point)
 		if point.point_type == :retweet
 			self.likes ||= 0 #TODO: why do I need to call self and not @?
 			self.likes += point.value 
 		end	
	 end
end