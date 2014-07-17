# code for sessions controller from "The Rails 4 Way"

class SessionsController < ApplicationController
  
  def new
  end

  def create
    # look for email and current season,
    # except admins do not have a season
    users = User.where(email: params[:email])
    # look for admin first...
    user = users.find {|u| u.admin? }
    # ... if no admin, look for user in current season
    if !user
      s = current_season
      user = users.find {|u| u.season.id == s.id } if s
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Successful sign in.'
      if user.admin?
        redirect_to admin_path
      else
        redirect_to user_path(user)
      end
    else
      flash[:alert] = 'Invalid email or password.'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out successfully.'
    redirect_to new_session_path
  end
end


