class Haiku
	include Mongoid::Document
	 field :screen_name, type: String
	 field :tweet_id, type: Integer
	 field :content, type: String

	 attr_accessible :screen_name, :tweet_id, :content
	 index({ tweet_id: -1 }) #TODO: find way to queue this index without having to rake manually

	 def self.pull_haikus
	 	Twitter.search("#JustAddGirls", since_id:max(:tweet_id)).results do |tweet|
	 		unless exists?(tweet_id:tweet.id)
	 			create!(
		          tweet_id: tweet.id,
		          content: tweet.text,
		          screen_name: tweet.user.screen_name,
		        )
	 		end
	 	end
	 end
end