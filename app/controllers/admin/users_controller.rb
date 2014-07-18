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
    if user.save
      flash[:notice] = "User #{params[:email]} created."
      redirect_to admin_users_path and return
    else
      flash.now[:warning] = "Unable to create user. "
      user.errors.each do | attr, msg |
        user.errors.full_messages_for(attr).each do | m |
          flash.now[:warning] << m
        end
      end
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    user = User.find(params[:id])

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
    authorize user
    if user.admin? && User.where(admin: true).count == 1
      flash[:alert] = "Cannot delete the ONLY admin user!"
    else
      flash[:notice] = "User #{user.email} deleted."
      user.destroy
    end
    redirect_to admin_users_path
  end
  
end
