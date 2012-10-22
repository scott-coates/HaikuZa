class NotificationService
	extend ActionView::Helpers::TextHelper
	def self.notify_user_of_points
		total_points = Point.sum(:value)
		percent_done = ((total_points / JustAddGirls::Application.config.goal_limit) * 100).to_i
		points = Point.where(:notified => false).in(point_type:[:retweet,:referal])
		if points
			user_with_points = points.group_by{|point| point.user}
			user_with_points.each do |user,point_group|
				point_total = 0
				point_group.each{|point| point.notified = true; point_total += point.value; point.save!;}
				message = "@#{user.screen_name} You've earned #{pluralize(point_total,'point')} for influencing and contributing to #17s. We're #{percent_done}% there!"
				Twitter.update("I'm tweeting with @gem!")
			end
		end
	end
end