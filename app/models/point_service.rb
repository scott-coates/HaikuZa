class PointService
	def self.pull_points
		#TODO: figure out how to mock this Haiku.max
	 	Twitter.search("#JustAddGirls", since_id:Haiku.max(:tweet_id)).statuses.each do |tweet|
	 		unless Haiku.where(tweet_id:tweet.id).exists?
	 			Haiku.create!(
		          tweet_id: tweet.id,
		          content: tweet.text,
		          screen_name: tweet.user.screen_name
		        )
	 		end
	 	end
	end
end