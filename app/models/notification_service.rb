class NotificationService
	extend ActionView::Helpers::TextHelper
	def self.notify_user_of_points
			map = %Q{
			 function(){
			 	var that = this;
			 	if(this.points){
				 	this.points.forEach(function(point){
				 		emit(that._id,point.value);
					});
				}
			 }
			}

			reduce = %Q{
				function(key, values) {
					var retVal = 0;
					values.forEach(function(value) {
						retVal += value;
					  });
					return retVal;
				}
			}
			total_points = User #TODO: find an easier way than to use MapReduce
				.map_reduce(map,reduce)
				.out(inline: true)
				.sum {|user| user["value"]}
		percent_done = ((total_points / JustAddGirls::Application.config.goal_limit) * 100).to_i
		points = Point.where(:notified => false).in(point_type:[:retweet,:referal])
		if points
			user_with_points = points.group_by{|point| point.user}
			user_with_points.each do |user,point_group|
				point_total = 0
				point_group.each{|point| point.notified = true; point_total += point.value;}
				message = "@#{user.screen_name} You've earned #{pluralize(point_total,'point')} for influencing and contributing to #17s. We're #{percent_done}% there!"
				user.save!
				Twitter.update("I'm tweeting with @gem!")
			end
		end
	end
end