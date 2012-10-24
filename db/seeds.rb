case Rails.env
when "development", "test"
	image_urls = [
		'http://a0.twimg.com/profile_images/2670580938/df1de53df54e3daf3835f58a2ecc1f28_normal.jpeg',
		'http://a0.twimg.com/profile_images/2714947253/85ff1300d70eb3c18c103eaa24fac33e_normal.png',
		'http://a0.twimg.com/profile_images/2749613086/600ab9f6c517aa26236ef6b71c59c093_normal.jpeg',
		'http://a0.twimg.com/profile_images/2599348440/vw71snljp111d713ba12_normal.jpeg',
		'http://a0.twimg.com/profile_images/2550613810/image_normal.jpg',
		'http://a0.twimg.com/profile_images/2617585837/locvxd35g60zlwof1by0_normal.png',
		"https://si0.twimg.com/profile_images/2452709870/wo2h8r0qy8d5lsxe5lgd_normal.png"
	]

	1.upto(100) {|i|
		the_user = User.new :profile_image_url => image_urls.sample,
			:screen_name => Faker::Name.name

		the_haiku = the_user.haikus.build(tweet_id: i, content: Faker::Lorem.sentence(13))
		the_user.add_point({point_type: :tweet, value:1, haiku: the_haiku})
		the_user.add_point({point_type: :retweet, value:5, haiku: the_haiku}) if i % 5 == 0
		the_user.add_point({point_type: :retweet, value:10, haiku: the_haiku}) if i  == 100
		the_user.save!
	}
end