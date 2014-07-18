class Admin::FishDatesController < ApplicationController
  before_filter :authenticate

  def show
    @date = FishDate.find(params[:id])
  end

  def index
    authorize FishDate.new
    @season = current_season
    @dates = FishDate.where(season: @season)
  end

  def new
    authorize FishDate.new
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
      if fdate.save
        flash[:notice] = "Date added to current season."
      else
        flash[:warning] = "Unable to create date. "
        fdate.errors.messages.each do | attr, msg |
          fdate.errors.full_messages_for(attr).each do | m |
            flash[:warning] << m
          end
        end
      end
    else
      flash[:alert] = "Date not within current season."
    end
    redirect_to admin_dates_path
  end

  def destroy
    fdate = FishDate.find(params[:id])
    if fdate
      authorize fdate
      flash[:notice] = "Date #{fdate.day.to_s} deleted."
      fdate.destroy
    end
    redirect_to admin_dates_path
  end

end
