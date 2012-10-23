require 'kaminari'

class MainCauseQuery
	def self.get_main_cause(page)
		ret_val = MainCauseViewModel.new
		ret_val.recent_haikus = recent_haikus(page)
		ret_val.top_referers = top_referers
		ret_val.top_haikus = top_haikus
		ret_val.progress = progress
		ret_val.goal_limit = JustAddGirls::Application.config.goal_limit
		ret_val
	end

	private 
		def self.recent_haikus(page)
			Haiku.desc(:tweet_id).page(page).per(5)
		end

		def self.top_referers
			map = %Q{
			 function(){
			 	var that = this;
			 	this.points.forEach(function(point){
			 		if(point.point_type === "retweet"){
			 			emit(that._id,point.value);
			 		}
				});
			 }
			}

			reduce = %Q{
				function(key, values) {
					var retVal = 0;
					values.forEach(function(value) {
						retVal += value;
						print(value);
					  });
					return retVal;
				}
			}
			top_referers = User
				.where("points.point_type" => :retweet) #TODO: wyh do examples online show hash : separator?
				.map_reduce(map,reduce)
				.out(inline: true)
				.sort_by {|user|user["value"]}.reverse! #TODO: why must I access by string not symbol?
				.take(2)
				.map do|user_points|
					user = User.find(user_points["_id"])
					user.instance_eval 'def referal_points; @referal_points; end; def referal_points=(x); @referal_points=x;end' #TODO: why is this so hard to do?
					user.referal_points = user_points["value"].to_i
					user 
					end
		end

		def self.top_haikus
			Haiku.desc(:points).take(2)
		end

		def self.progress
			progress = {:points => 0, :percentage_complete => 0}
			total_points = Point.sum(:value)
			if(total_points)
				progress[:percentage_complete] = (total_points / JustAddGirls::Application.config.goal_limit) * 100
				progress[:points] = total_points
			end

			progress
		end
end