class UsersController < ApplicationController
  before_filter :authenticate

  def show
    @user = User.find(params[:id])
    authorize @user
    @slots = @user.slots
    @num_slots = @user.slots.count
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
    user.firstname = params[:firstname] if params[:firstname]
    user.lastname = params[:lastname] if params[:lastname]
    user.phone = params[:phone] if params[:phone]
    user.save!
    flash[:notice] = "Properties updated."
    redirect_to user_path(user)
  end
end
