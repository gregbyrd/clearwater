class Admin::SeasonsController < ApplicationController
  before_filter :authenticate

  def index
    authorize Season.new
    @seasons = Season.all
    @current = find_current_season()
  end

  def show
    @season = Season.find(params[:id])
    if @season
      authorize @season
      @dates = @season.fish_dates
    else
      @dates = nil
    end
  end

  def new
    authorize Season.new
  end

  def create
    season = Season.new
    authorize season
    season.year = params[:date][:year].to_i
    season.start_month = params[:date][:start_month].to_i
    season.end_month = params[:date][:end_month].to_i
    season.slot_limit = params[:slot_limit].to_i
    if season.save
      flash.notice = "Season #{season.year} created."
      redirect_to admin_seasons_path
    else
      flash.now[:warning] = "Unable to create season. "
      season.errors.messages.each do | attr, msg |
        season.errors.full_messages_for(attr).each do | m |
          flash.now[:warning] << m
        end
      end
      render :new
    end
  end

  def update
    Properties.instance.update_attribute(:current_season_id, params[:id])
    session[:season_id] = nil if session[:season_id]
    redirect_to admin_seasons_path
  end

  def destroy
    @season = Season.find(params[:id])
    if @season 
      if @season.id == current_season.id
        flash.now[:warning] = "Cannot destroy current season."
        redirect_to admin_seasons_path
      else
        year = @season.year
        users = @season.users
        dates = @season.fish_dates
        users.each do |u|
          u.destroy
        end
        dates.each do |d|
          d.destroy
        end
        @season.destroy
        flash.notice = "Season #{year} deleted."
        redirect_to admin_seasons_path
      end
    else
      flash.now[:warning] = "ERROR: no such season -- cannot destroy."
      redirect_to admin_seasons_path
    end
  end
end
