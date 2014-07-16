class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized

  helper_method :current_user
  helper_method :current_season

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_season
    @current_season ||= find_current_season
  end

  def authenticate
    unless current_user
      redirect_to new_session_url, 
        alert: 'You need to sign in before continuing'
    end
  end

  def unauthorized
    render nothing: true, status: 403
  end

  private
  
  def find_current_season
    # current season is (a) provided by session, (b) set by Properties
    # object, or (c) defaults to the one with the latest start date
    csid = session[:season_id] || Properties.instance.current_season_id
    if csid
      Season.find(csid)
    else
      Season.order(year: :desc, start_month: :desc).first
    end
  end


end
