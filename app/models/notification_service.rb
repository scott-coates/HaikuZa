class NotificationService
	extend ActionView::Helpers::TextHelper
	def self.notify_users_of_points
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
		users_to_notify = User.where("points.notified" => false)
		users_to_notify.each do |user|
			points = user.points.where(:notified => false)
			if points
				point_total = 0
				points.each do |point|
					point.notified = true
					point_total += point.value
				end
				message = "@#{user.screen_name} You've earned another #{pluralize(point_total,'point')} for influencing and contributing to #geekitude. We're #{percent_done}% there!"
				user.save!
				begin
					Twitter.update(message)
				rescue Twitter::Error::Forbidden #occurs if a duplicate retweet - that's okay
				end
			end
		end
	end
end