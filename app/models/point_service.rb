class PointService
	def self.pull_points_from_external_networks
		Twitter.search("@just_add_girls #17s -from:just_add_girls", since_id:Haiku.max(:tweet_id)).statuses.each do |tweet|
			unless tweet.user.screen_name.downcase == "just_add_girls" #do not include jag
				user = find_or_create_user tweet
				if tweet.retweet?
					user.save!
					the_haiku = Haiku.where(tweet_id:tweet.retweeted_status.id).first || self.create_haiku(tweet.retweeted_status, self.find_or_create_user(tweet.retweeted_status))
					the_point = the_haiku.user.add_point({point_type: :retweet, value:10,haiku: the_haiku, voted_user:user, notified: false})
					the_haiku.user.save!
				else
					unless Haiku.where(tweet_id:tweet.id).exists?
						self.create_haiku tweet,user
						user.save!
					end
				end
			end
		end
	end

	private

	def self.create_haiku(tweet,user)
		the_haiku = user.haikus.build(
		tweet_id: tweet.id,
		content: tweet.text
		)
		user.add_point({point_type: :tweet, value:5,haiku: the_haiku})

		begin
			Twitter.retweet(tweet.id)
		rescue Twitter::Error::Forbidden #occurs if a duplicate retweet - that's okay
		end

		the_haiku
	end

	def self.find_or_create_user(tweet)
		User.where(:screen_name=>tweet.user.screen_name).first || User.new(
		uid: tweet.user.id,
		screen_name: tweet.user.screen_name,
		name: tweet.user.name,
		registered: false,
		provider: "twitter",
		profile_image_url: tweet.user.profile_image_url
		)
	end
end