require 'kaminari'

class MainCauseQuery
	def self.get_main_cause(page)
		ret_val = MainCauseViewModel.new
		ret_val.recent_haikus = Haiku.desc(:tweet_id).page(page)
		ret_val
	end
end