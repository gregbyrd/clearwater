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
    session[:reserve_date] = params[:fish_date]
    session[:reserve_slots] = params[:num_slots]
    redirect_to reservations_newlabels_path(user)
  end

  def destroy
  end

  def newlabels
    @user = User.find(params[:user_id])
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
      @slots = []
      reserve_slots.times do
        @slots << Slot.create!(user: @user, fish_date: @date,
                               label: 'pending')
      end
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
    reserve_date = session[:reserve_date]
    session.delete(:reserve_date)
    session.delete(:reserve_slots)
    if reserve_date
      date = FishDate.find(reserve_date)
      slots = Slot.where(user: user, fish_date: date, label: 'pending')
      slots.each do |s|
        case params["label_#{s.id}"]
          when 'self'
            s.label = 'self'
          when 'select'
            s.label = params["label_#{s.id}_select"]
          when 'new'
            guest = params["label_new_#{s.id}"]
            s.label = guest
            user.guests << guest
        end
      end
    else
      flash[:alert] = "Error during reservation.  Please try again."
      redirect_to new_user_reservation_path(user) and return
    end
    redirect_to user_path(user)
  end
end
