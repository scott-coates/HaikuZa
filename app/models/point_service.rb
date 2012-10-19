class PointService
	def self.pull_points_from_external_networks
	 	Twitter.search("#JustAddGirls #17s", since_id:Haiku.max(:tweet_id)).statuses.each do |tweet|
	 		user = User.where(:name=>tweet.user.screen_name).first || User.create!(
	 													uid: tweet.user.id,
	 													name: tweet.user.screen_name,
	 													registered: false,
	 													profile_image_url: tweet.user.profile_image_url
													)	
	 		if tweet.retweet?
	 			the_haiku = Haiku.where(tweet_id:tweet.id).first #TODO:make sure original tweet exists
	 			the_haiku.user.add_point({point_type: :retweet, value:5,haiku: the_haiku, voted_up_user:user})
		 	else
		 		unless Haiku.where(tweet_id:tweet.id).exists?
		 			the_haiku = Haiku.create!(
			          tweet_id: tweet.id,
			          content: tweet.text,
			          screen_name: tweet.user.screen_name,
			          user:user
			        )
	 				user.add_point({point_type: :tweet, value:1,haiku: the_haiku})
	 			end
		 	end
	 	end
	end
end