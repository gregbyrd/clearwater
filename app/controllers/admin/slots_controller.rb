class Admin::SlotsController < ApplicationController
  before_filter :authenticate

  def user_authorized?
    current_user.admin
  end

  def new
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    @date = FishDate.find(params[:date_id])
    @display = :users
    @users = User.where(admin: false)
  end

  def create
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    session[:reserve_date] = params[:date_id]
    session[:reserve_slots] = params[:num_slots]
    # get selected user from radio button
    if params[:user] == 'admin'
      user = current_user
    else
      user = User.find(params[:user])
    end
    redirect_to reservations_newlabels_path(user)
  end

  def edit
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    @slot = Slot.find(params[:id])
    @user = @slot.user
    @date = @slot.fish_date
  end

  def update
    # check authorization manually
    if !user_authorized?
      raise Pundit::NotAuthorizedError
    end
    slot = Slot.where(id: params[:id]).includes(:fish_date, :user).first
    newlabel = ''
    case params[:newlabel]
      when /self/
        newlabel = 'self'
      when /new/
        newlabel = params[:newlabel_guest]
    end
    if newlabel != slot.label
      slot.label = newlabel
      slot.save
    end
    redirect_to admin_date_path(slot.fish_date)
  end
    
end
