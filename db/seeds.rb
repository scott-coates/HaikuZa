class User
	after_save do |the_user|
		the_haiku = Haiku.new(tweet_id: 1, content: "hello world")
		the_haiku.user = the_user
		the_haiku.save
  		the_user.add_point({point_type: :tweet, value:1, haiku: the_haiku})
	end
end

1.upto(100) {|i|
	the_user =  User.create! :name => "user#{'%03d' % i}",:email=> "user#{'%03d' % i}@jag.com",:age => i / 2
}

# class User
# 	after_save do |the_user|
#   		the_user.add_point({point_type: :tweet, value:1, haiku: the_haiku})
# 	end
# end

# 1.upto(100) {|i|
# 	Haiku.create!(tweet_id: 1, content: "hello world") do |haiku|
# 		haiku.user =  User.create! :name => "user#{'%03d' % i}",:email=> "user#{'%03d' % i}@jag.com",:age => i / 2 do |user|
# 			user.add_point({point_type: :tweet, value:1, haiku: haiku})
# 		end

# 	end
# }