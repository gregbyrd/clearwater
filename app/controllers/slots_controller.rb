class SlotsController < ApplicationController
  before_filter :authenticate
  def new
    # check authorization manually
#    if params[:user_id] != session[:user_id]
#      raise Pundit::NotAuthorizedError
#    end
    @user = User.find(params[:user_id])
    @display = :dates
    @dates = FishDate.where(season: current_season)
  end

  def create
    user = User.find(params[:user_id])
    date = FishDate.find(params[:fish_date])
    slot = Slot.create(label: 'self', fish_date: date, user: user)
    flash[:notice] = "Reservation successful."
    redirect_to user_path(user)
  end

  def destroy
  end
end
