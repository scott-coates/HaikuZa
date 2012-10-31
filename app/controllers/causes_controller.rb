class CausesController < ApplicationController
	def main
		@view_model = MainCauseQuery.get_main_cause params[:page]
		referer = params[:referer]
		if(referer)
			the_user = User.where(:screen_name => referer).first
			if the_user
				the_user.add_point({ip: request.ip, point_type: :referal, value:15, notified: false}) 
				the_user.save!
				flash[:referer] = {:screen_name => the_user.screen_name}
			end
			params.delete :referer
			redirect_to main_cause_path
		end
	end
end