require 'kaminari'

class MainCauseQuery
	def self.get_main_cause(page)
		ret_val = MainCauseViewModel.new
		ret_val.recent_haikus = Haiku.desc(:tweet_id).page(page)
		ret_val.top_haikus = Haiku.desc(:points).limit(2)
		ret_val
	end
end