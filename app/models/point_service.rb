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
	 			
		        unless User.where(name:tweet.user.screen_name).exists?
			        User.create!(
			          uid: tweet.user.id,
			          name: tweet.user.screen_name,
			          registered: false,
			          profile_image_url: tweet.user.profile_image_url
			        )	
		        end
	 		end
	 	end
	end
end