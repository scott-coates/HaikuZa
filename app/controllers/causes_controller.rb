class CausesController < ApplicationController
	def main
		@view_model = MainCauseQuery.get_main_cause params[:page]
		referer = params[:referer]
		if(referer)
			the_user = User.where(:screen_name => referer).first
			the_user.add_point({point_type: :referal, value:10}) if the_user
			the_user.save!
			params.delete :referer
			redirect_to main_cause_path
		end
	end
end