class SlotsController < ApplicationController
  before_filter :authenticate
  def user_authorized?
    params[:user_id].to_i == session[:user_id] || current_user.admin
  end
    
    
  def new
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    @user = User.find(params[:user_id])
    @display = :dates
    @dates = FishDate.where(season: current_season)
  end

  def create
    user = User.find(params[:user_id])
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    session[:reserve_date] = params[:fish_date]
    session[:reserve_slots] = params[:num_slots]
    redirect_to reservations_newlabels_path(user)
  end

  def newlabels
    @user = User.find(params[:user_id])
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    reserve_date = session[:reserve_date]
    reserve_slots = session[:reserve_slots].to_i
    if reserve_date && reserve_slots
      @date = FishDate.find(reserve_date)
      if @date.available(true) < reserve_slots
        flash[:alert] = "Slots are not available."
        session.delete(:reserve_date)
        session.delete(:reserve_slots)
        redirect_to new_user_reservation_path(@user) and return
      end
      @num_slots = reserve_slots
      render :slot_labels and return
    else
      flash[:alert] = "Error during reservation.  Please try again."
      session.delete(:reserve_date)
      session.delete(:reserve_slots)
      redirect_to new_user_reservation_path(user)
    end
  end

  def setlabels
    user = User.find(params[:user_id])
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    reserve_date = session[:reserve_date]
    reserve_slots = session[:reserve_slots].to_i
    session.delete(:reserve_date)
    session.delete(:reserve_slots)
    if reserve_date
      date = FishDate.find(reserve_date) 
    else
      flash[:alert] = "Error during reservation.  Please try again."
      redirect_to new_user_reservation_path(user) and return
    end
    new_guest = false
    reserve_slots.times do |i|
      label = ''
      case params["label_#{i}"]
      when 'self'
        label = 'self'
      when 'select'
        label = params["label_#{i}_select"]
      when 'new'
        guest = params["label_new_#{i}"]
        label = guest
        user.guests << guest
        new_guest = true
      end
      Slot.create!(user: user, fish_date: date, label: label)
    end
    if new_guest
      user.guests.sort!
      user.save
    end
    if user == current_user
      redirect_to user_path(user)
    else
      redirect_to admin_date_path(date)
    end
  end
end
