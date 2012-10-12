class HomeController < ApplicationController
  def index
  end

  def users
    @users = User.all
  end
end
