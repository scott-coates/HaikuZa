1.upto(100) {|i|
	the_user = User.create! :profile_image_url => "https://si0.twimg.com/profile_images/2452709870/wo2h8r0qy8d5lsxe5lgd_normal.png",
		:screen_name => Faker::Name.name,
		:email=> Faker::Internet.email

	the_haiku = Haiku.new(tweet_id: i, content: Faker::Lorem.sentence(13))
	the_haiku.user = the_user 
	the_haiku.save!
	the_user.add_point({point_type: :tweet, value:1, haiku: the_haiku})
	the_user.add_point({point_type: :retweet, value:5, haiku: the_haiku}) if i % 5 == 0
	the_user.add_point({point_type: :retweet, value:10, haiku: the_haiku}) if i  == 100
}