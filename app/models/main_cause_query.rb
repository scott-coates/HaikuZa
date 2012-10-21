require 'kaminari'

class MainCauseQuery
	def self.get_main_cause(page = 1)
		ret_val = MainCauseViewModel.new
		ret_val.recent_haikus = Haiku.page(page)
		ret_val
	end
end