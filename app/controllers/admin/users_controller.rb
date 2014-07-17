class Admin::UsersController < ApplicationController
  before_filter :authenticate

  def index
    authorize User.new
    @admin_users = User.where(admin: true)
    @seasons = Season.all.sort {|a,b| b.year <=> a.year }

  end

  def new
    authorize User.new
  end

  def create
    user = User.new
    authorize user
    user.password = params[:password]
    user.password_confirmation = params[:password]
    user.email = params[:email]
    if params[:make_admin]
      user.admin = true
    else
      user.season = current_season
      user.purchased = params[:slots].to_i
      user.admin = false
    end
    user.save!
    flash[:notice] = "User #{params[:email]} created."
    redirect_to admin_users_path      
  end
  
end
