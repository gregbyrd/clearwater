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

  def edit
    @user = User.find(params[:id])
    if @user
      authorize @user
      render :edit
    else
      render nothing: true, status: :not_found
    end
  end

  def update
    user = User.find(params[:id])
    head :internal_server_error if !user

    authorize user
    user.firstname = params[:firstname] if params[:firstname]
    user.lastname = params[:lastname] if params[:lastname]
    user.phone = params[:phone] if params[:phone]
    user.email = params[:email]
    if params[:password]
      user.password = params[:password]
      user.password_confirmation = params[:password]
    end
    user.purchased = params[:slots].to_i
    user.save!
    flash[:notice] = "User #{params[:email]} updated."
    redirect_to admin_users_path
  end

  def destroy
    user = User.find(params[:id])
    if user
      authorize user
      flash[:notice] = "User #{user.email} deleted."
      user.destroy
    else
      flash[:warning] = "DELETE: User not found."
    end
    redirect_to admin_users_path
  end
  
end
