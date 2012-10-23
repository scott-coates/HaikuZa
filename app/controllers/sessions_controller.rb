class SessionsController < ApplicationController

  def new
    session[:return_url] = request.referer
    redirect_to '/auth/twitter'
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to session[:return_url] || root_url
    session.delete(:return_url)
  end

  def destroy
    reset_session
    redirect_to request.referer
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
