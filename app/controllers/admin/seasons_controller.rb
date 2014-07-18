class Admin::SeasonsController < ApplicationController
  before_filter :authenticate

  def index
    authorize Season.new
    @seasons = Season.all
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
end
