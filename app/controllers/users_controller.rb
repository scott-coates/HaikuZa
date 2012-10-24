class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:join]
  before_filter :correct_user?, :except => [:index,:join]

  def index
    @users = User.all
  end

    def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


def show
    @user = User.find(params[:id])
  end

  def join
    session[:return_url] = (params[:return_url] || main_cause_path)
  end
end
