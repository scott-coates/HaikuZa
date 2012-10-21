1.upto(100) {|i|
	the_user = User.create! :screen_name => "user#{'%03d' % i}",:email=> "user#{'%03d' % i}@jag.com",:age => i / 2
	the_haiku = Haiku.new(tweet_id: 1, content: "hello world")
	the_haiku.user = the_user 
	the_haiku.save!
	the_user.add_point({point_type: :tweet, value:1, haiku: the_haiku})
}