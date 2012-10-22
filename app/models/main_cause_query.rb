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
			 	emit(this.user_id, this.value); 
			 }
			}

			reduce = %Q{
				function(key, values) {
					var  retVal = 0; 
					for (var i = 0; i < values.length; ++i) { 
						retVal += values[i]; 
					} 
					return retVal;
				}
			}
			top_referers = Point
				.where(:point_type => :retweet)
				.map_reduce(map,reduce)
				.out(inline: true)
				.sort_by {|user_points| user_points["value"]}.reverse!
				.take(2)
				.map do|user_points|
					user = User.find(user_points["_id"])
					user.instance_eval 'def referal_points; @referal_points; end; def referal_points=(x); @referal_points=x;end'
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