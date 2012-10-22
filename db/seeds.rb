1.upto(100) {|i|
	the_user = User.create! :profile_image_url => "https://si0.twimg.com/profile_images/2452709870/wo2h8r0qy8d5lsxe5lgd_normal.png",
		:screen_name => "user#{'%03d' % i}",
		:email=> "user#{'%03d' % i}@jag.com",
		:age => i / 2

	the_haiku = Haiku.new(tweet_id: i, content: "hello world")
	the_haiku.user = the_user 
	the_haiku.save!
	the_user.add_point({point_type: :tweet, value:1, haiku: the_haiku})
}