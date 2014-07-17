class Admin::FishDatesController < ApplicationController
  before_filter :authenticate

  def index
    authorize FishDate.new
    @dates = FishDate.where(season: current_season)
  end

  def new
    @newdate = FishDate.new
    authorize @newdate
  end

  def create
    fdate = FishDate.new(season: current_season)
    authorize fdate
    day = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, 
                   params[:date][:day].to_i)
    if day && day >= current_season.start_date && day <= current_season.end_date
      fdate.day = day
      if params[:slots]
        fdate.slot_limit = params[:slots]
      else
        fdate.slot_limit = current_season.slot_limit
      end
      fdate.save!
      flash[:notice] = "Date added to current season."
      redirect_to admin_fish_dates_path
    else
      flash[:alert] = "Date not within current season."
      redirect_to admin_fish_dates_path
    end
  end

end
