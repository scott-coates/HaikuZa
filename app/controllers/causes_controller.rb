class CausesController < ApplicationController
	def main
		@view_model = MainCauseQuery.get_main_cause
	end
end