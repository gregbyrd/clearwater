# code for sessions controller from "The Rails 4 Way"

class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_path
      else
        redirect_to user_path(user)
      end
    else
      flash[:notice] = 'Invalid email or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out successfully.'
    render :new
  end
end


