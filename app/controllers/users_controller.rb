class UsersController < ApplicationController
  before_filter :authenticate

  def show
    @user = User.find(params[:id])
    authorize @user
    @slots = @user.slots.sort_by {|s| s.fish_date.day }
    @num_slots = @user.slots.count
    @in_current_season = @user.season.id == current_season.id
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    user = User.find(params[:id])
    authorize user
    if params[:password]
      if params[:password_confirm] &&
          params[:password] == params[:password_confirm]
        user.password = params[:password]
        user.password_confirmation = params[:password]
      else
        flash[:alert] = "Password and confirmation do not match -- no changes made."
        redirect_to edit_user_path(user) and return
      end
    end
    user.firstname = params[:firstname] if params[:firstname] != user.firstname
    user.lastname = params[:lastname] if params[:lastname] != user.lastname
    user.phone = params[:phone] if params[:phone] != user.phone
    user.save!
    flash[:notice] = "Properties updated."
    redirect_to user_path(user)
  end
end
